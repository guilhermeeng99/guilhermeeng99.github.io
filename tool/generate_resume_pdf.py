#!/usr/bin/env python3
"""Build the website résumé PDF from the portfolio's English resume data."""

from __future__ import annotations

import html
import json
from pathlib import Path

from reportlab.lib import colors
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.platypus import (
    KeepTogether,
    PageBreak,
    Paragraph,
    SimpleDocTemplate,
    Spacer,
    Table,
    TableStyle,
)


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "lib/app/assets/i18n/en.i18n.json"
DESTINATION = ROOT / "web/resume.pdf"
EMAIL = "guilhermeeng99@gmail.com"
WEBSITE = "https://guilhermeeng99.github.io/"
LINKEDIN = "https://www.linkedin.com/in/guigapassos/"

NAVY = colors.HexColor("#14233B")
BLUE = colors.HexColor("#316CFF")
TEXT = colors.HexColor("#253247")
MUTED = colors.HexColor("#617087")
RULE = colors.HexColor("#DCE3ED")
PALE_BLUE = colors.HexColor("#F1F5FF")


def text(value: str) -> str:
    """Escape source strings and use plain ASCII dashes in the PDF."""
    normalized = (
        value.replace("\u2011", "-")
        .replace("\u2013", "-")
        .replace("\u2014", "-")
        .replace("\u2019", "'")
        .replace("\u2018", "'")
    )
    return html.escape(normalized)


def build_styles():
    styles = getSampleStyleSheet()
    styles.add(
        ParagraphStyle(
            "Name",
            parent=styles["Normal"],
            fontName="Helvetica-Bold",
            fontSize=26,
            leading=29,
            textColor=NAVY,
            spaceAfter=3,
        )
    )
    styles.add(
        ParagraphStyle(
            "Headline",
            parent=styles["Normal"],
            fontName="Helvetica-Bold",
            fontSize=10,
            leading=13,
            textColor=BLUE,
            spaceAfter=5,
        )
    )
    styles.add(
        ParagraphStyle(
            "Contact",
            parent=styles["Normal"],
            fontName="Helvetica",
            fontSize=8,
            leading=11,
            textColor=MUTED,
        )
    )
    styles.add(
        ParagraphStyle(
            "Summary",
            parent=styles["Normal"],
            fontName="Helvetica",
            fontSize=8.8,
            leading=12.2,
            textColor=TEXT,
        )
    )
    styles.add(
        ParagraphStyle(
            "Section",
            parent=styles["Normal"],
            fontName="Helvetica-Bold",
            fontSize=10.5,
            leading=13,
            textColor=NAVY,
            spaceBefore=2,
            spaceAfter=6,
        )
    )
    styles.add(
        ParagraphStyle(
            "RoleTitle",
            parent=styles["Normal"],
            fontName="Helvetica-Bold",
            fontSize=9.4,
            leading=11.4,
            textColor=NAVY,
        )
    )
    styles.add(
        ParagraphStyle(
            "RoleMeta",
            parent=styles["Normal"],
            fontName="Helvetica",
            fontSize=7.8,
            leading=10,
            textColor=MUTED,
        )
    )
    styles.add(
        ParagraphStyle(
            "BulletText",
            parent=styles["Normal"],
            fontName="Helvetica",
            fontSize=8.15,
            leading=10.5,
            textColor=TEXT,
            leftIndent=9,
            firstLineIndent=-7,
            bulletIndent=0,
            spaceAfter=2.3,
        )
    )
    styles.add(
        ParagraphStyle(
            "ProjectTitle",
            parent=styles["Normal"],
            fontName="Helvetica-Bold",
            fontSize=8.8,
            leading=10.5,
            textColor=BLUE,
            spaceAfter=2,
        )
    )
    styles.add(
        ParagraphStyle(
            "ProjectBody",
            parent=styles["Normal"],
            fontName="Helvetica",
            fontSize=8,
            leading=10.2,
            textColor=TEXT,
        )
    )
    styles.add(
        ParagraphStyle(
            "SkillHeading",
            parent=styles["Normal"],
            fontName="Helvetica-Bold",
            fontSize=8.2,
            leading=10,
            textColor=NAVY,
        )
    )
    styles.add(
        ParagraphStyle(
            "EducationTitle",
            parent=styles["Normal"],
            fontName="Helvetica-Bold",
            fontSize=8.4,
            leading=10,
            textColor=NAVY,
        )
    )
    return styles


def make_section(title: str, width: float, styles) -> Table:
    section = Table([[Paragraph(text(title.upper()), styles["Section"])]], colWidths=[width])
    section.setStyle(
        TableStyle(
            [
                ("LINEBELOW", (0, 0), (-1, -1), 0.8, RULE),
                ("LEFTPADDING", (0, 0), (-1, -1), 0),
                ("RIGHTPADDING", (0, 0), (-1, -1), 0),
                ("TOPPADDING", (0, 0), (-1, -1), 0),
                ("BOTTOMPADDING", (0, 0), (-1, -1), 3),
            ]
        )
    )
    return section


def role_block(role: dict, company: str, styles, page_width: float) -> KeepTogether:
    title = text(role["title"])
    period = text(role["period"])
    top = Table(
        [[Paragraph(title, styles["RoleTitle"]), Paragraph(period, styles["RoleMeta"]) ]],
        colWidths=[page_width - 112, 112],
        hAlign="LEFT",
    )
    top.setStyle(
        TableStyle(
            [
                ("ALIGN", (1, 0), (1, 0), "RIGHT"),
                ("VALIGN", (0, 0), (-1, -1), "TOP"),
                ("LEFTPADDING", (0, 0), (-1, -1), 0),
                ("RIGHTPADDING", (0, 0), (-1, -1), 0),
                ("TOPPADDING", (0, 0), (-1, -1), 0),
                ("BOTTOMPADDING", (0, 0), (-1, -1), 0),
            ]
        )
    )
    meta = f"{company}  |  {role.get('employment_type', '')}  |  {role['location']}"
    elements = [top, Paragraph(text(meta), styles["RoleMeta"]), Spacer(1, 2)]
    elements.extend(
        Paragraph(f"&#8226; {text(point)}", styles["BulletText"])
        for point in role["points"]
    )
    elements.append(Spacer(1, 5))
    return KeepTogether(elements)


def draw_footer(canvas, document):
    canvas.saveState()
    canvas.setStrokeColor(RULE)
    canvas.setLineWidth(0.55)
    canvas.line(document.leftMargin, 27, A4[0] - document.rightMargin, 27)
    canvas.setFont("Helvetica", 7)
    canvas.setFillColor(MUTED)
    canvas.drawString(document.leftMargin, 16, "Guilherme Passos  |  Resume  |  September 2026")
    canvas.drawRightString(A4[0] - document.rightMargin, 16, f"Page {canvas.getPageNumber()}")
    canvas.restoreState()


def main():
    data = json.loads(SOURCE.read_text(encoding="utf-8"))
    resume = data["resume"]
    experience = resume["experience"]
    companies = {
        "sixty_six_degrees": "66degrees",
        "arc_dev": "Arc.dev",
        "blu_studios": "blu studios",
        "vx_case": "VX Case",
        "tecall": "TECALL CONSULTORIA E SISTEMAS LTDA",
    }
    styles = build_styles()
    page_width = A4[0] - 88
    story = []

    story.append(Paragraph("Guilherme Passos", styles["Name"]))
    story.append(
        Paragraph(
            "Senior Software Engineer  |  Flutter, Mobile &amp; Full-Stack  |  AI-Enabled Products",
            styles["Headline"],
        )
    )
    contact = (
        f'<link href="{WEBSITE}" color="#617087">Portfolio</link>  |  '
        f'<link href="{LINKEDIN}" color="#617087">LinkedIn</link>  |  '
        f'<link href="mailto:{EMAIL}" color="#617087">{EMAIL}</link>  |  Cork, Ireland'
    )
    story.append(Paragraph(contact, styles["Contact"]))
    story.append(Spacer(1, 11))
    story.append(make_section("Summary", page_width, styles))
    story.append(Spacer(1, 5))
    story.append(
        Paragraph(
            "Senior Software Engineer with 8+ years of software engineering experience, building Flutter, mobile, and full-stack products. I have led products from architecture and implementation through launch and live operations. Apps and games I have built and maintained have reached 12M+ downloads worldwide.",
            styles["Summary"],
        )
    )
    story.append(Spacer(1, 8))

    metrics = [[
        Paragraph('<font color="#316CFF"><b>8+ years</b></font><br/><font size="7.2" color="#617087">Software engineering</font>', styles["Contact"]),
        Paragraph('<font color="#316CFF"><b>12M+ downloads</b></font><br/><font size="7.2" color="#617087">Worldwide product reach</font>', styles["Contact"]),
        Paragraph('<font color="#316CFF"><b>14 people</b></font><br/><font size="7.2" color="#617087">Largest team co-led</font>', styles["Contact"]),
    ]]
    metric_table = Table(metrics, colWidths=[page_width / 3] * 3)
    metric_table.setStyle(
        TableStyle(
            [
                ("BACKGROUND", (0, 0), (-1, -1), PALE_BLUE),
                ("BOX", (0, 0), (-1, -1), 0.4, RULE),
                ("INNERGRID", (0, 0), (-1, -1), 0.4, RULE),
                ("LEFTPADDING", (0, 0), (-1, -1), 10),
                ("RIGHTPADDING", (0, 0), (-1, -1), 7),
                ("TOPPADDING", (0, 0), (-1, -1), 7),
                ("BOTTOMPADDING", (0, 0), (-1, -1), 7),
                ("VALIGN", (0, 0), (-1, -1), "MIDDLE"),
            ]
        )
    )
    story.extend([metric_table, Spacer(1, 12), make_section("Professional Experience", page_width, styles), Spacer(1, 7)])

    for key in ("sixty_six_degrees", "arc_dev", "blu_studios"):
        story.append(role_block(experience[key], companies[key], styles, page_width))

    story.append(PageBreak())
    story.extend([make_section("Previous Experience", page_width, styles), Spacer(1, 7)])
    for key in ("vx_case", "tecall"):
        story.append(role_block(experience[key], companies[key], styles, page_width))

    story.extend([Spacer(1, 4), make_section("Selected Projects", page_width, styles), Spacer(1, 6)])
    featured_projects = [
        ("movement_challenge", "Movement Challenge App", "Rebuilt a movement challenge platform in Flutter with health-data sync, event rankings, a Community feed, role-based admin tools, and an in-app AI help assistant."),
        ("magic_sort", "Magic Sort", "Google Play Indie Games Accelerator 2024 winner; shipped high-performance Flutter gameplay and live-ops systems."),
        ("rabit", "Rabit", "Google Play Best of 2021 selection and 5M+ downloads; built habit-tracking, cloud sync, and retention features."),
        ("capy", "Capy", "Flutter self-care app combining a virtual pet, habit tracking, mood journaling, and AI-powered conversations."),
    ]
    for _key, project_name, project_description in featured_projects:
        story.append(
            KeepTogether(
                [
                    Paragraph(text(project_name), styles["ProjectTitle"]),
                    Paragraph(text(project_description), styles["ProjectBody"]),
                    Spacer(1, 5),
                ]
            )
        )

    story.extend([Spacer(1, 2), make_section("Skills", page_width, styles), Spacer(1, 6)])
    skill_rows = [
        ("Engineering", "Flutter, Dart, mobile and web development, TypeScript, Angular, modular architecture, state management, testing"),
        ("Data &amp; AI", "Firebase, Firestore, Supabase, REST APIs, row-level security, OpenAI APIs, voice-enabled AI experiences"),
        ("Production", "Performance optimization, analytics, CI/CD, release workflows, technical leadership, remote team collaboration"),
    ]
    for heading, values in skill_rows:
        story.append(
            KeepTogether(
                [
                    Paragraph(heading, styles["SkillHeading"]),
                    Paragraph(text(values), styles["ProjectBody"]),
                    Spacer(1, 4),
                ]
            )
        )

    story.extend([Spacer(1, 2), make_section("Education", page_width, styles), Spacer(1, 6)])
    institutions = {
        "ucsal": "Universidade Católica do Salvador",
        "senai_cimatec": "SENAI CIMATEC",
        "all": "Alternative Language Learning (ALL)",
    }
    for key, education in resume["education"].items():
        line = Table(
            [[
                Paragraph(text(education["degree"]), styles["EducationTitle"]),
                Paragraph(text(education["period"]), styles["RoleMeta"]),
            ]],
            colWidths=[page_width - 70, 70],
        )
        line.setStyle(
            TableStyle(
                [
                    ("ALIGN", (1, 0), (1, 0), "RIGHT"),
                    ("VALIGN", (0, 0), (-1, -1), "TOP"),
                    ("LEFTPADDING", (0, 0), (-1, -1), 0),
                    ("RIGHTPADDING", (0, 0), (-1, -1), 0),
                    ("TOPPADDING", (0, 0), (-1, -1), 0),
                    ("BOTTOMPADDING", (0, 0), (-1, -1), 0),
                ]
            )
        )
        story.append(
            KeepTogether(
                [
                    line,
                    Paragraph(
                        f"{text(institutions[key])}  |  {text(education['location'])}",
                        styles["RoleMeta"],
                    ),
                    Spacer(1, 5),
                ]
            )
        )

    document = SimpleDocTemplate(
        str(DESTINATION),
        pagesize=A4,
        leftMargin=44,
        rightMargin=44,
        topMargin=38,
        bottomMargin=42,
        title="Guilherme Passos - Senior Software Engineer Resume",
        author="Guilherme Passos",
        subject="Software engineering experience, selected projects, skills, and education",
    )
    document.build(story, onFirstPage=draw_footer, onLaterPages=draw_footer)
    print(f"Generated {DESTINATION}")


if __name__ == "__main__":
    main()
