///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsAppEn app = TranslationsAppEn._(_root);
	late final TranslationsNavEn nav = TranslationsNavEn._(_root);
	late final TranslationsHeroEn hero = TranslationsHeroEn._(_root);
	late final TranslationsAboutEn about = TranslationsAboutEn._(_root);
	late final TranslationsProjectsEn projects = TranslationsProjectsEn._(_root);
	late final TranslationsResumeEn resume = TranslationsResumeEn._(_root);
	late final TranslationsSkillsEn skills = TranslationsSkillsEn._(_root);
	late final TranslationsContactEn contact = TranslationsContactEn._(_root);
}

// Path: app
class TranslationsAppEn {
	TranslationsAppEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Guilherme Passos - Flutter Engineer'
	String get title => 'Guilherme Passos - Flutter Engineer';

	/// en: '12M+'
	String get total_downloads => '12M+';
}

// Path: nav
class TranslationsNavEn {
	TranslationsNavEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'About'
	String get about => 'About';

	/// en: 'Projects'
	String get projects => 'Projects';

	/// en: 'Experience'
	String get experience => 'Experience';

	/// en: 'Skills'
	String get skills => 'Skills';

	/// en: 'Contact'
	String get contact => 'Contact';
}

// Path: hero
class TranslationsHeroEn {
	TranslationsHeroEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Guilherme Passos'
	String get name => 'Guilherme\nPassos';

	/// en: 'Senior Flutter Engineer'
	String get role => 'Senior Flutter Engineer';

	/// en: 'Flutter Engineer & Mobile Entrepreneur with 7+ years crafting high-performance apps and games reaching 12M+ downloads worldwide.'
	String get description => 'Flutter Engineer & Mobile Entrepreneur with 7+ years crafting high-performance apps and games reaching ${_root.app.total_downloads} downloads worldwide.';

	/// en: 'Explore Projects'
	String get explore_projects => 'Explore Projects';

	/// en: 'Get In Touch'
	String get get_in_touch => 'Get In Touch';
}

// Path: about
class TranslationsAboutEn {
	TranslationsAboutEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'About Me'
	String get title => 'About Me';

	/// en: 'Building digital products that scale'
	String get subtitle => 'Building digital products that scale';

	/// en: 'Senior Flutter Engineer with over seven years of experience and seven years as an entrepreneur focused exclusively on mobile games and mobile applications.'
	String get bio1 => 'Senior Flutter Engineer with over seven years of experience and seven years as an entrepreneur focused exclusively on mobile games and mobile applications.';

	/// en: 'I've implemented mobile products from scratch, including titles that surpassed 1M+ downloads, one of which was selected and awarded by the Google Play Indie Games Fund. Altogether, the apps and games I've built and maintained have reached 12M+ downloads worldwide.'
	String get bio2 => 'I\'ve implemented mobile products from scratch, including titles that surpassed 1M+ downloads, one of which was selected and awarded by the Google Play Indie Games Fund. Altogether, the apps and games I\'ve built and maintained have reached 12M+ downloads worldwide.';

	/// en: 'I specialize in scalable architectures, long-term code maintainability, and high-performance mobile applications. My expertise spans multiple state management solutions (Riverpod, Bloc, MobX), native plugin integration, and the full Firebase ecosystem.'
	String get bio3 => 'I specialize in scalable architectures, long-term code maintainability, and high-performance mobile applications. My expertise spans multiple state management solutions (Riverpod, Bloc, MobX), native plugin integration, and the full Firebase ecosystem.';

	late final TranslationsAboutStatsEn stats = TranslationsAboutStatsEn._(_root);
}

// Path: projects
class TranslationsProjectsEn {
	TranslationsProjectsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Featured Projects'
	String get title => 'Featured Projects';

	/// en: 'Real-world products across games and mobile apps'
	String get subtitle => 'Real-world products across games and mobile apps';

	/// en: 'What i did in this project'
	String get details_button => 'What i did in this project';

	/// en: 'Other Projects'
	String get other_projects_toggle => 'Other Projects';

	/// en: 'View on Store'
	String get view_on_store => 'View on Store';

	/// en: 'downloads'
	String get downloads_suffix => 'downloads';

	late final TranslationsProjectsItemsEn items = TranslationsProjectsItemsEn._(_root);
}

// Path: resume
class TranslationsResumeEn {
	TranslationsResumeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Resume'
	String get title => 'Resume';

	/// en: 'A summary of my professional experience and education'
	String get subtitle => 'A summary of my professional experience and education';

	/// en: 'Professional Experience'
	String get experience_title => 'Professional Experience';

	/// en: 'Education'
	String get education_title => 'Education';

	/// en: 'Download Resume'
	String get download_resume => 'Download Resume';

	late final TranslationsResumeExperienceEn experience = TranslationsResumeExperienceEn._(_root);
	late final TranslationsResumeEducationEn education = TranslationsResumeEducationEn._(_root);
}

// Path: skills
class TranslationsSkillsEn {
	TranslationsSkillsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Skills & Expertise'
	String get title => 'Skills & Expertise';

	/// en: 'Technologies and tools I use to bring ideas to life'
	String get subtitle => 'Technologies and tools I use to bring ideas to life';

	late final TranslationsSkillsCategoriesEn categories = TranslationsSkillsCategoriesEn._(_root);
}

// Path: contact
class TranslationsContactEn {
	TranslationsContactEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Let's Work Together'
	String get title => 'Let\'s Work Together';

	/// en: 'Have a project in mind or want to discuss opportunities? I'm always open to new challenges and collaborations.'
	String get subtitle => 'Have a project in mind or want to discuss opportunities? I\'m always open to new challenges and collaborations.';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'GitHub'
	String get github => 'GitHub';

	/// en: 'LinkedIn'
	String get linkedin => 'LinkedIn';

	/// en: '© 2026 Guilherme Passos - Flutter Engineer. Built with'
	String get footer => '© 2026 ${_root.app.title}. Built with';

	/// en: 'Flutter.'
	String get flutter => 'Flutter.';
}

// Path: about.stats
class TranslationsAboutStatsEn {
	TranslationsAboutStatsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsAboutStatsDownloadsEn downloads = TranslationsAboutStatsDownloadsEn._(_root);
	late final TranslationsAboutStatsExperienceEn experience = TranslationsAboutStatsExperienceEn._(_root);
	late final TranslationsAboutStatsProductsEn products = TranslationsAboutStatsProductsEn._(_root);
	late final TranslationsAboutStatsTeamSizeEn teamSize = TranslationsAboutStatsTeamSizeEn._(_root);
}

// Path: projects.items
class TranslationsProjectsItemsEn {
	TranslationsProjectsItemsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsProjectsItemsMagicSortEn magic_sort = TranslationsProjectsItemsMagicSortEn._(_root);
	late final TranslationsProjectsItemsRabitEn rabit = TranslationsProjectsItemsRabitEn._(_root);
	late final TranslationsProjectsItemsCupsEn cups = TranslationsProjectsItemsCupsEn._(_root);
	late final TranslationsProjectsItemsFarmVsAliensEn farm_vs_aliens = TranslationsProjectsItemsFarmVsAliensEn._(_root);
	late final TranslationsProjectsItemsCapyEn capy = TranslationsProjectsItemsCapyEn._(_root);
	late final TranslationsProjectsItemsDropMergeEn drop_merge = TranslationsProjectsItemsDropMergeEn._(_root);
	late final TranslationsProjectsItemsNeverHaveIEverXEn never_have_i_ever_x = TranslationsProjectsItemsNeverHaveIEverXEn._(_root);
	late final TranslationsProjectsItemsBoozeEn booze = TranslationsProjectsItemsBoozeEn._(_root);
	late final TranslationsProjectsItemsVdxEn vdx = TranslationsProjectsItemsVdxEn._(_root);
	late final TranslationsProjectsItemsFinancoEn financo = TranslationsProjectsItemsFinancoEn._(_root);
	late final TranslationsProjectsItemsHarvestEn harvest = TranslationsProjectsItemsHarvestEn._(_root);
	late final TranslationsProjectsItemsBluBiEn blu_bi = TranslationsProjectsItemsBluBiEn._(_root);
}

// Path: resume.experience
class TranslationsResumeExperienceEn {
	TranslationsResumeExperienceEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsResumeExperienceBluStudiosEn blu_studios = TranslationsResumeExperienceBluStudiosEn._(_root);
	late final TranslationsResumeExperienceVxCaseEn vx_case = TranslationsResumeExperienceVxCaseEn._(_root);
	late final TranslationsResumeExperienceTecallEn tecall = TranslationsResumeExperienceTecallEn._(_root);
}

// Path: resume.education
class TranslationsResumeEducationEn {
	TranslationsResumeEducationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsResumeEducationUcsalEn ucsal = TranslationsResumeEducationUcsalEn._(_root);
	late final TranslationsResumeEducationSenaiCimatecEn senai_cimatec = TranslationsResumeEducationSenaiCimatecEn._(_root);
	late final TranslationsResumeEducationAllEn all = TranslationsResumeEducationAllEn._(_root);
}

// Path: skills.categories
class TranslationsSkillsCategoriesEn {
	TranslationsSkillsCategoriesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsSkillsCategoriesCoreEngineeringEn core_engineering = TranslationsSkillsCategoriesCoreEngineeringEn._(_root);
	late final TranslationsSkillsCategoriesArchitectureBackendEn architecture_backend = TranslationsSkillsCategoriesArchitectureBackendEn._(_root);
	late final TranslationsSkillsCategoriesDevopsProductionEn devops_production = TranslationsSkillsCategoriesDevopsProductionEn._(_root);
}

// Path: about.stats.downloads
class TranslationsAboutStatsDownloadsEn {
	TranslationsAboutStatsDownloadsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '12M+'
	String get value => _root.app.total_downloads;

	/// en: 'Downloads'
	String get label => 'Downloads';
}

// Path: about.stats.experience
class TranslationsAboutStatsExperienceEn {
	TranslationsAboutStatsExperienceEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '7+'
	String get value => '7+';

	/// en: 'Years Experience'
	String get label => 'Years Experience';
}

// Path: about.stats.products
class TranslationsAboutStatsProductsEn {
	TranslationsAboutStatsProductsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '10+'
	String get value => '10+';

	/// en: 'Products Shipped'
	String get label => 'Products Shipped';
}

// Path: about.stats.teamSize
class TranslationsAboutStatsTeamSizeEn {
	TranslationsAboutStatsTeamSizeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '14'
	String get value => '14';

	/// en: 'Max Team Size Co-led'
	String get label => 'Max Team Size Co-led';
}

// Path: projects.items.magic_sort
class TranslationsProjectsItemsMagicSortEn {
	TranslationsProjectsItemsMagicSortEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Magic Sort'
	String get name => 'Magic Sort';

	/// en: 'Hybrid casual puzzle game built in partnership with Wildlife Studios. Selected for Google Play's Indie Games Accelerator 2024 and reached 1M+ downloads, powered by live-ops-driven monetization and engagement systems.'
	String get description => 'Hybrid casual puzzle game built in partnership with Wildlife Studios. Selected for Google Play\'s Indie Games Accelerator 2024 and reached 1M+ downloads, powered by live-ops-driven monetization and engagement systems.';

	/// en: '1M+'
	String get metric => '1M+';

	/// en: 'Indie Games Accelerator 2024'
	String get award => 'Indie Games Accelerator 2024';

	/// en: 'Led the team's UI architecture and shipped a high-performance Flutter codebase tuned for low-end Android devices. Reduced frame build time, memory footprint, and frame jank via deep profiling, rendering optimizations, and targeted refactors. Built monetization and content-delivery pipelines using Firebase Remote Config and A/B testing, lifting engagement and revenue per session. Implemented event-driven state management with feature isolation, enabling fast, scalable Live Ops releases without regressions.'
	String get details => 'Led the team\'s UI architecture and shipped a high-performance Flutter codebase tuned for low-end Android devices. Reduced frame build time, memory footprint, and frame jank via deep profiling, rendering optimizations, and targeted refactors. Built monetization and content-delivery pipelines using Firebase Remote Config and A/B testing, lifting engagement and revenue per session. Implemented event-driven state management with feature isolation, enabling fast, scalable Live Ops releases without regressions.';
}

// Path: projects.items.rabit
class TranslationsProjectsItemsRabitEn {
	TranslationsProjectsItemsRabitEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Rabit'
	String get name => 'Rabit';

	/// en: 'Gamified habit tracker that reached 5M+ downloads worldwide and earned a Google Play Best of 2021 selection. Turns daily routines into streaks worth keeping through delightful UX and behavior-driven engagement loops.'
	String get description => 'Gamified habit tracker that reached 5M+ downloads worldwide and earned a Google Play Best of 2021 selection. Turns daily routines into streaks worth keeping through delightful UX and behavior-driven engagement loops.';

	/// en: '5M+'
	String get metric => '5M+';

	/// en: 'Google Play Best of 2021'
	String get award => 'Google Play Best of 2021';

	/// en: 'Developed the core engagement systems: push notifications, streak logic, Firestore sync, and high-performance animated UI. Built data-driven retention features (cohort analysis, behavioral nudges, personalized reminder windows) that meaningfully lifted D1 and D7 retention. Tuned rendering and animation pipelines for smooth performance on low-end Android devices.'
	String get details => 'Developed the core engagement systems: push notifications, streak logic, Firestore sync, and high-performance animated UI. Built data-driven retention features (cohort analysis, behavioral nudges, personalized reminder windows) that meaningfully lifted D1 and D7 retention. Tuned rendering and animation pipelines for smooth performance on low-end Android devices.';
}

// Path: projects.items.cups
class TranslationsProjectsItemsCupsEn {
	TranslationsProjectsItemsCupsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cups'
	String get name => 'Cups';

	/// en: 'Water-sort puzzle game co-developed with Homa Games. Reached 4.5M+ downloads with strong traction in the US market through tight gameplay loops and broad-reach monetization.'
	String get description => 'Water-sort puzzle game co-developed with Homa Games. Reached 4.5M+ downloads with strong traction in the US market through tight gameplay loops and broad-reach monetization.';

	/// en: '4.5M+'
	String get metric => '4.5M+';

	/// en: 'Implemented the full UI layer and the monetization stack (rewarded ads, interstitials, eCPM-aware placements). Co-led performance optimization initiatives that reduced frame build time and improved smoothness on low-end Android devices, directly expanding the addressable audience. Co-owned the publishing and release pipeline alongside the Homa partnership team.'
	String get details => 'Implemented the full UI layer and the monetization stack (rewarded ads, interstitials, eCPM-aware placements). Co-led performance optimization initiatives that reduced frame build time and improved smoothness on low-end Android devices, directly expanding the addressable audience. Co-owned the publishing and release pipeline alongside the Homa partnership team.';
}

// Path: projects.items.farm_vs_aliens
class TranslationsProjectsItemsFarmVsAliensEn {
	TranslationsProjectsItemsFarmVsAliensEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Farm vs Aliens'
	String get name => 'Farm vs Aliens';

	/// en: 'Mobile game blending merge mechanics with tower-defense progression. Backed by Google Play's Indie Games Fund 2023, recognized for original gameplay and a strong vertical slice.'
	String get description => 'Mobile game blending merge mechanics with tower-defense progression. Backed by Google Play\'s Indie Games Fund 2023, recognized for original gameplay and a strong vertical slice.';

	/// en: 'Indie Games Fund 2023'
	String get award => 'Indie Games Fund 2023';

	/// en: 'Led product direction and designed the core gameplay loop. Owned feature prioritization, scope, and implementation strategy across the team, work that directly contributed to the studio securing Google Play Indie Games Fund backing. Built in Unity to leverage its 2D animation tooling and performance characteristics suited for merge-grid simulations.'
	String get details => 'Led product direction and designed the core gameplay loop. Owned feature prioritization, scope, and implementation strategy across the team, work that directly contributed to the studio securing Google Play Indie Games Fund backing. Built in Unity to leverage its 2D animation tooling and performance characteristics suited for merge-grid simulations.';
}

// Path: projects.items.capy
class TranslationsProjectsItemsCapyEn {
	TranslationsProjectsItemsCapyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Capy – AI-Powered Virtual Wellness Companion'
	String get name => 'Capy – AI-Powered Virtual Wellness Companion';

	/// en: 'AI-powered self-care companion built around a virtual pet that grows with the user. Combines habit tracking, mood journaling, and context-aware conversations powered by OpenAI APIs to make daily wellness feel personal.'
	String get description => 'AI-powered self-care companion built around a virtual pet that grows with the user. Combines habit tracking, mood journaling, and context-aware conversations powered by OpenAI APIs to make daily wellness feel personal.';

	/// en: 'Designed and built scalable daily engagement loops with push notifications, streak mechanics, and behavioral tracking, driving retention and reinforcing consistent user habits. Led high-performance UI architecture with smooth pet animations and responsive interactions across devices. Integrated OpenAI APIs for context-aware companion responses tied to the user's current mood and journal entries.'
	String get details => 'Designed and built scalable daily engagement loops with push notifications, streak mechanics, and behavioral tracking, driving retention and reinforcing consistent user habits. Led high-performance UI architecture with smooth pet animations and responsive interactions across devices. Integrated OpenAI APIs for context-aware companion responses tied to the user\'s current mood and journal entries.';
}

// Path: projects.items.drop_merge
class TranslationsProjectsItemsDropMergeEn {
	TranslationsProjectsItemsDropMergeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Drop & Merge'
	String get name => 'Drop & Merge';

	/// en: 'Drop-and-merge puzzle game combining strategic placement with satisfying merge mechanics for a tight, engaging casual loop.'
	String get description => 'Drop-and-merge puzzle game combining strategic placement with satisfying merge mechanics for a tight, engaging casual loop.';

	/// en: 'Implemented the complete UI layer with smooth merge animations, drop physics feedback, and responsive grid interactions. Tuned rendering for stable frame times on low-end Android devices.'
	String get details => 'Implemented the complete UI layer with smooth merge animations, drop physics feedback, and responsive grid interactions. Tuned rendering for stable frame times on low-end Android devices.';
}

// Path: projects.items.never_have_i_ever_x
class TranslationsProjectsItemsNeverHaveIEverXEn {
	TranslationsProjectsItemsNeverHaveIEverXEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Never Have I Ever X'
	String get name => 'Never Have I Ever X';

	/// en: 'Party game app where players uncover surprising facts about each other through classic 'Never Have I Ever' rounds. Reached 500K+ downloads on the back of share-driven viral loops.'
	String get description => 'Party game app where players uncover surprising facts about each other through classic \'Never Have I Ever\' rounds. Reached 500K+ downloads on the back of share-driven viral loops.';

	/// en: '500K+'
	String get metric => '500K+';

	/// en: 'Implemented the UI, hundreds of curated questions across multiple categories, and social sharing features. Integrated ad monetization (rewarded + interstitial) and analytics to optimize engagement and revenue per session.'
	String get details => 'Implemented the UI, hundreds of curated questions across multiple categories, and social sharing features. Integrated ad monetization (rewarded + interstitial) and analytics to optimize engagement and revenue per session.';
}

// Path: projects.items.booze
class TranslationsProjectsItemsBoozeEn {
	TranslationsProjectsItemsBoozeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Booze'
	String get name => 'Booze';

	/// en: 'Drinking party game with creative challenges, mini-games, and social mechanics designed for fun group gatherings. Reached 500K+ downloads through friend-driven discovery.'
	String get description => 'Drinking party game with creative challenges, mini-games, and social mechanics designed for fun group gatherings. Reached 500K+ downloads through friend-driven discovery.';

	/// en: '500K+'
	String get metric => '500K+';

	/// en: 'Implemented the UI, diverse challenge modes, customizable game rules, and group-play mechanics. Built smooth animations, ad monetization (rewarded + interstitial), and Firebase analytics to track engagement and session data.'
	String get details => 'Implemented the UI, diverse challenge modes, customizable game rules, and group-play mechanics. Built smooth animations, ad monetization (rewarded + interstitial), and Firebase analytics to track engagement and session data.';
}

// Path: projects.items.vdx
class TranslationsProjectsItemsVdxEn {
	TranslationsProjectsItemsVdxEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Truth or Dare X'
	String get name => 'Truth or Dare X';

	/// en: 'Party game app where friends challenge each other through classic 'Truth or Dare' prompts. Reached 1M+ downloads through tight session loops and share-driven distribution.'
	String get description => 'Party game app where friends challenge each other through classic \'Truth or Dare\' prompts. Reached 1M+ downloads through tight session loops and share-driven distribution.';

	/// en: '1M+'
	String get metric => '1M+';

	/// en: 'Implemented the UI, hundreds of curated prompts across multiple categories, multiplayer session management, and social sharing features. Integrated ad monetization (rewarded + interstitial) and analytics to optimize engagement and revenue per session.'
	String get details => 'Implemented the UI, hundreds of curated prompts across multiple categories, multiplayer session management, and social sharing features. Integrated ad monetization (rewarded + interstitial) and analytics to optimize engagement and revenue per session.';
}

// Path: projects.items.financo
class TranslationsProjectsItemsFinancoEn {
	TranslationsProjectsItemsFinancoEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Financo'
	String get name => 'Financo';

	/// en: 'Cross-platform personal finance manager with AI-powered natural-language entry. Users describe expenses via text, receipt photos, or voice, and Vertex AI Gemini parses them into structured transactions for one-tap confirmation. Targets Android, iOS, and Web.'
	String get description => 'Cross-platform personal finance manager with AI-powered natural-language entry. Users describe expenses via text, receipt photos, or voice, and Vertex AI Gemini parses them into structured transactions for one-tap confirmation. Targets Android, iOS, and Web.';

	/// en: 'Built on Clean Architecture with feature-first layering (domain/data/presentation). Implemented multi-account management (checking + credit cards with linking), hierarchical categorization, cross-account transfers, recurring bills with auto-generation, CSV bulk import, and a dashboard with month/year filters, income-vs-expense summaries, category breakdowns, and evolution charts. Backed by Cloud Functions (Node.js 22 + TypeScript) running Vertex AI Gemini for the multimodal chat pipeline (text, image, voice transcription). Stack: flutter_bloc (Cubits + Blocs) • go_router • get_it • Firebase Auth + Google Sign-In • Cloud Firestore (sync) • Drift/SQLite (offline) • FCM + flutter_local_notifications (overdue-bill alerts) • fl_chart • dartz (Either<Failure, T>) • slang i18n. Spec-driven workflow with markdown contracts per feature. Layered testing with mocktail + bloc_test + fake_cloud_firestore. CI/CD via GitHub Actions signs and deploys Android + Web on every push to main.'
	String get details => 'Built on Clean Architecture with feature-first layering (domain/data/presentation). Implemented multi-account management (checking + credit cards with linking), hierarchical categorization, cross-account transfers, recurring bills with auto-generation, CSV bulk import, and a dashboard with month/year filters, income-vs-expense summaries, category breakdowns, and evolution charts. Backed by Cloud Functions (Node.js 22 + TypeScript) running Vertex AI Gemini for the multimodal chat pipeline (text, image, voice transcription). Stack: flutter_bloc (Cubits + Blocs) • go_router • get_it • Firebase Auth + Google Sign-In • Cloud Firestore (sync) • Drift/SQLite (offline) • FCM + flutter_local_notifications (overdue-bill alerts) • fl_chart • dartz (Either<Failure, T>) • slang i18n. Spec-driven workflow with markdown contracts per feature. Layered testing with mocktail + bloc_test + fake_cloud_firestore. CI/CD via GitHub Actions signs and deploys Android + Web on every push to main.';
}

// Path: projects.items.harvest
class TranslationsProjectsItemsHarvestEn {
	TranslationsProjectsItemsHarvestEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Harvest'
	String get name => 'Harvest';

	/// en: 'Production-Ready App 24-Hours-AI'
	String get award => 'Production-Ready App 24-Hours-AI';

	/// en: 'Fresh food e-commerce app connecting local farmers directly with their communities. Perishable-first product catalog with a fast, reliable shopping experience, shipped end-to-end in a 24-hour AI-assisted build.'
	String get description => 'Fresh food e-commerce app connecting local farmers directly with their communities. Perishable-first product catalog with a fast, reliable shopping experience, shipped end-to-end in a 24-hour AI-assisted build.';

	/// en: 'Architected with Clean Architecture and a feature-first structure across 13 features for long-term scalability and maintainability. Implemented Firebase Auth with email/password and Google Sign-In using platform-specific OAuth flows (popup on web, credential on mobile). Built a reusable UI component system with 8+ shared widgets and a complete Material 3 design system (Fresh Harvest palette, Poppins/Inter typography). Designed a centralized BLoC startup coordinator that pre-loads all data before navigation, eliminating per-page loading states. Structured a role-based admin system via a secure Firestore collection guarded by server-side security rules. Wrote 48+ unit tests covering domain entities, repository cache logic, and BLoC state machines with bloc_test and mocktail.'
	String get details => 'Architected with Clean Architecture and a feature-first structure across 13 features for long-term scalability and maintainability. Implemented Firebase Auth with email/password and Google Sign-In using platform-specific OAuth flows (popup on web, credential on mobile). Built a reusable UI component system with 8+ shared widgets and a complete Material 3 design system (Fresh Harvest palette, Poppins/Inter typography). Designed a centralized BLoC startup coordinator that pre-loads all data before navigation, eliminating per-page loading states. Structured a role-based admin system via a secure Firestore collection guarded by server-side security rules. Wrote 48+ unit tests covering domain entities, repository cache logic, and BLoC state machines with bloc_test and mocktail.';
}

// Path: projects.items.blu_bi
class TranslationsProjectsItemsBluBiEn {
	TranslationsProjectsItemsBluBiEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Blu BI'
	String get name => 'Blu BI';

	/// en: 'Business Intelligence app for tracking and visualizing financial data: revenue, expenses, and project-based results with charts, Income Statement (DRE) reports, and period analysis. Multiplatform (Android, iOS, Web, Windows, macOS, Linux).'
	String get description => 'Business Intelligence app for tracking and visualizing financial data: revenue, expenses, and project-based results with charts, Income Statement (DRE) reports, and period analysis. Multiplatform (Android, iOS, Web, Windows, macOS, Linux).';

	/// en: 'Built on Clean Architecture with self-contained feature modules (auth, finance, projects, company, personal) registered via GetX bindings. Implemented Google Sign-In with biometric (local_auth) protection, offline-first persistence via Isar, REST integration via Dio, and Firebase Remote Config for feature flags. Built dashboards and analytics with fl_chart: revenue/expense bar and pie charts, project-level financial breakdowns, money goals per category, and period-based reporting. Used Freezed + json_serializable for immutable models and get_it for dependency injection. Responsive layouts adapt cleanly from mobile to desktop. Stack: Flutter • GetX (state + navigation) • Firebase Auth + Google Sign-In • Firebase Remote Config • Dio • Isar • fl_chart • Freezed + json_serializable • get_it • local_auth.'
	String get details => 'Built on Clean Architecture with self-contained feature modules (auth, finance, projects, company, personal) registered via GetX bindings. Implemented Google Sign-In with biometric (local_auth) protection, offline-first persistence via Isar, REST integration via Dio, and Firebase Remote Config for feature flags. Built dashboards and analytics with fl_chart: revenue/expense bar and pie charts, project-level financial breakdowns, money goals per category, and period-based reporting. Used Freezed + json_serializable for immutable models and get_it for dependency injection. Responsive layouts adapt cleanly from mobile to desktop. Stack: Flutter • GetX (state + navigation) • Firebase Auth + Google Sign-In • Firebase Remote Config • Dio • Isar • fl_chart • Freezed + json_serializable • get_it • local_auth.';
}

// Path: resume.experience.blu_studios
class TranslationsResumeExperienceBluStudiosEn {
	TranslationsResumeExperienceBluStudiosEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Co-founder & Senior Flutter Engineer'
	String get title => 'Co-founder & Senior Flutter Engineer';

	/// en: '2019 – 2026'
	String get period => '2019 – 2026';

	/// en: 'Remote'
	String get location => 'Remote';

	List<String> get points => [
		'Built and maintained multiple mobile apps and games totaling ${_root.app.total_downloads} downloads worldwide.',
		'Architected scalable Flutter applications supporting millions of users.',
		'Executed deep performance optimization initiatives, reducing ANR rates from approximately 30% to below 2% and improving frame rendering stability on low-end Android devices.',
		'Designed and implemented live ops systems (Battle Pass, Leaderboards, Events, Ranking Systems).',
		'Improved D1 retention from approximately 25% to approximately 40% through UX performance tuning and data-driven iteration.',
		'Reduced APK size by 45% through asset restructuring, rendering optimizations, and build configuration improvements.',
		'Integrated Firebase (Analytics, Firestore, Remote Config, Crashlytics, Cloud Messaging).',
		'Implemented monetization systems (Rewarded Ads, Interstitials, IAP) achieving high eCPM performance.',
		'Co-owned the full product lifecycle: architecture, development, CI/CD, publishing, ASO, live ops, store compliance.',
		'Co-led fully remote teams of up to 14 members.',
		'Established partnerships with Wildlife Studios and Homa Games.',
	];
}

// Path: resume.experience.vx_case
class TranslationsResumeExperienceVxCaseEn {
	TranslationsResumeExperienceVxCaseEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Desktop Engineer'
	String get title => 'Desktop Engineer';

	/// en: 'Oct 2018 – Mar 2019'
	String get period => 'Oct 2018 – Mar 2019';

	/// en: 'Salvador, Brazil'
	String get location => 'Salvador, Brazil';

	List<String> get points => [
		'Developed a desktop application focused on user interface implementation using TypeScript, Angular, and VTEX.',
		'Built reusable UI components ensuring usability, scalability, and design consistency.',
		'Collaborated with senior engineers to integrate frontend features with backend services.',
	];
}

// Path: resume.experience.tecall
class TranslationsResumeExperienceTecallEn {
	TranslationsResumeExperienceTecallEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'IT Support'
	String get title => 'IT Support';

	/// en: 'Jan 2018 – Oct 2018'
	String get period => 'Jan 2018 – Oct 2018';

	/// en: 'Salvador, Brazil'
	String get location => 'Salvador, Brazil';

	List<String> get points => [
		'Provided technical support and infrastructure troubleshooting for corporate clients.',
		'Assisted in system maintenance and hardware configuration.',
		'Gained foundational experience in networking, system administration, and customer support.',
	];
}

// Path: resume.education.ucsal
class TranslationsResumeEducationUcsalEn {
	TranslationsResumeEducationUcsalEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Bachelor's Degree in Software Engineering'
	String get degree => 'Bachelor\'s Degree in Software Engineering';

	/// en: '2017 – 2019'
	String get period => '2017 – 2019';

	/// en: 'Salvador, Brazil'
	String get location => 'Salvador, Brazil';

	List<String> get points => [
		'Emphasis on software development methodologies, object-oriented programming, data structures, algorithms, databases, and system architecture.',
		'Gained experience in designing, developing, testing, and maintaining software applications using modern technologies and industry best practices.',
		'Participated in collaborative projects and hands-on activities that strengthened problem-solving skills and prepared me to work effectively in team-based development environments.',
	];
}

// Path: resume.education.senai_cimatec
class TranslationsResumeEducationSenaiCimatecEn {
	TranslationsResumeEducationSenaiCimatecEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Technical Course in Computer Networks'
	String get degree => 'Technical Course in Computer Networks';

	/// en: '2017 – 2018'
	String get period => '2017 – 2018';

	/// en: 'Salvador, Brazil'
	String get location => 'Salvador, Brazil';

	List<String> get points => [
		'Focusing on the installation, configuration, administration, and maintenance of computer networks in both home and corporate environments.',
		'Throughout the training, I developed skills in network topologies, device connectivity, network infrastructure, communication protocols, and information security practices.',
		'The program included extensive hands-on lab experience, enabling me to implement network solutions effectively and apply industry-standard technical best practices.',
	];
}

// Path: resume.education.all
class TranslationsResumeEducationAllEn {
	TranslationsResumeEducationAllEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Certificate in English Language'
	String get degree => 'Certificate in English Language';

	/// en: '2013 – 2016'
	String get period => '2013 – 2016';

	/// en: 'Salvador, Brazil'
	String get location => 'Salvador, Brazil';

	List<String> get points => [
		'Intensive English language program with focus on grammar, reading, writing, listening and speaking skills. Prepared for advanced communication in academic and professional environments.',
	];
}

// Path: skills.categories.core_engineering
class TranslationsSkillsCategoriesCoreEngineeringEn {
	TranslationsSkillsCategoriesCoreEngineeringEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Core Engineering'
	String get title => 'Core Engineering';
}

// Path: skills.categories.architecture_backend
class TranslationsSkillsCategoriesArchitectureBackendEn {
	TranslationsSkillsCategoriesArchitectureBackendEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Architecture & Backend Systems'
	String get title => 'Architecture & Backend Systems';
}

// Path: skills.categories.devops_production
class TranslationsSkillsCategoriesDevopsProductionEn {
	TranslationsSkillsCategoriesDevopsProductionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'DevOps, Observability & Production'
	String get title => 'DevOps, Observability & Production';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => 'Guilherme Passos - Flutter Engineer',
			'app.total_downloads' => '12M+',
			'nav.about' => 'About',
			'nav.projects' => 'Projects',
			'nav.experience' => 'Experience',
			'nav.skills' => 'Skills',
			'nav.contact' => 'Contact',
			'hero.name' => 'Guilherme\nPassos',
			'hero.role' => 'Senior Flutter Engineer',
			'hero.description' => 'Flutter Engineer & Mobile Entrepreneur with 7+ years crafting high-performance apps and games reaching ${_root.app.total_downloads} downloads worldwide.',
			'hero.explore_projects' => 'Explore Projects',
			'hero.get_in_touch' => 'Get In Touch',
			'about.title' => 'About Me',
			'about.subtitle' => 'Building digital products that scale',
			'about.bio1' => 'Senior Flutter Engineer with over seven years of experience and seven years as an entrepreneur focused exclusively on mobile games and mobile applications.',
			'about.bio2' => 'I\'ve implemented mobile products from scratch, including titles that surpassed 1M+ downloads, one of which was selected and awarded by the Google Play Indie Games Fund. Altogether, the apps and games I\'ve built and maintained have reached 12M+ downloads worldwide.',
			'about.bio3' => 'I specialize in scalable architectures, long-term code maintainability, and high-performance mobile applications. My expertise spans multiple state management solutions (Riverpod, Bloc, MobX), native plugin integration, and the full Firebase ecosystem.',
			'about.stats.downloads.value' => _root.app.total_downloads,
			'about.stats.downloads.label' => 'Downloads',
			'about.stats.experience.value' => '7+',
			'about.stats.experience.label' => 'Years Experience',
			'about.stats.products.value' => '10+',
			'about.stats.products.label' => 'Products Shipped',
			'about.stats.teamSize.value' => '14',
			'about.stats.teamSize.label' => 'Max Team Size Co-led',
			'projects.title' => 'Featured Projects',
			'projects.subtitle' => 'Real-world products across games and mobile apps',
			'projects.details_button' => 'What i did in this project',
			'projects.other_projects_toggle' => 'Other Projects',
			'projects.view_on_store' => 'View on Store',
			'projects.downloads_suffix' => 'downloads',
			'projects.items.magic_sort.name' => 'Magic Sort',
			'projects.items.magic_sort.description' => 'Hybrid casual puzzle game built in partnership with Wildlife Studios. Selected for Google Play\'s Indie Games Accelerator 2024 and reached 1M+ downloads, powered by live-ops-driven monetization and engagement systems.',
			'projects.items.magic_sort.metric' => '1M+',
			'projects.items.magic_sort.award' => 'Indie Games Accelerator 2024',
			'projects.items.magic_sort.details' => 'Led the team\'s UI architecture and shipped a high-performance Flutter codebase tuned for low-end Android devices. Reduced frame build time, memory footprint, and frame jank via deep profiling, rendering optimizations, and targeted refactors. Built monetization and content-delivery pipelines using Firebase Remote Config and A/B testing, lifting engagement and revenue per session. Implemented event-driven state management with feature isolation, enabling fast, scalable Live Ops releases without regressions.',
			'projects.items.rabit.name' => 'Rabit',
			'projects.items.rabit.description' => 'Gamified habit tracker that reached 5M+ downloads worldwide and earned a Google Play Best of 2021 selection. Turns daily routines into streaks worth keeping through delightful UX and behavior-driven engagement loops.',
			'projects.items.rabit.metric' => '5M+',
			'projects.items.rabit.award' => 'Google Play Best of 2021',
			'projects.items.rabit.details' => 'Developed the core engagement systems: push notifications, streak logic, Firestore sync, and high-performance animated UI. Built data-driven retention features (cohort analysis, behavioral nudges, personalized reminder windows) that meaningfully lifted D1 and D7 retention. Tuned rendering and animation pipelines for smooth performance on low-end Android devices.',
			'projects.items.cups.name' => 'Cups',
			'projects.items.cups.description' => 'Water-sort puzzle game co-developed with Homa Games. Reached 4.5M+ downloads with strong traction in the US market through tight gameplay loops and broad-reach monetization.',
			'projects.items.cups.metric' => '4.5M+',
			'projects.items.cups.details' => 'Implemented the full UI layer and the monetization stack (rewarded ads, interstitials, eCPM-aware placements). Co-led performance optimization initiatives that reduced frame build time and improved smoothness on low-end Android devices, directly expanding the addressable audience. Co-owned the publishing and release pipeline alongside the Homa partnership team.',
			'projects.items.farm_vs_aliens.name' => 'Farm vs Aliens',
			'projects.items.farm_vs_aliens.description' => 'Mobile game blending merge mechanics with tower-defense progression. Backed by Google Play\'s Indie Games Fund 2023, recognized for original gameplay and a strong vertical slice.',
			'projects.items.farm_vs_aliens.award' => 'Indie Games Fund 2023',
			'projects.items.farm_vs_aliens.details' => 'Led product direction and designed the core gameplay loop. Owned feature prioritization, scope, and implementation strategy across the team, work that directly contributed to the studio securing Google Play Indie Games Fund backing. Built in Unity to leverage its 2D animation tooling and performance characteristics suited for merge-grid simulations.',
			'projects.items.capy.name' => 'Capy – AI-Powered Virtual Wellness Companion',
			'projects.items.capy.description' => 'AI-powered self-care companion built around a virtual pet that grows with the user. Combines habit tracking, mood journaling, and context-aware conversations powered by OpenAI APIs to make daily wellness feel personal.',
			'projects.items.capy.details' => 'Designed and built scalable daily engagement loops with push notifications, streak mechanics, and behavioral tracking, driving retention and reinforcing consistent user habits. Led high-performance UI architecture with smooth pet animations and responsive interactions across devices. Integrated OpenAI APIs for context-aware companion responses tied to the user\'s current mood and journal entries.',
			'projects.items.drop_merge.name' => 'Drop & Merge',
			'projects.items.drop_merge.description' => 'Drop-and-merge puzzle game combining strategic placement with satisfying merge mechanics for a tight, engaging casual loop.',
			'projects.items.drop_merge.details' => 'Implemented the complete UI layer with smooth merge animations, drop physics feedback, and responsive grid interactions. Tuned rendering for stable frame times on low-end Android devices.',
			'projects.items.never_have_i_ever_x.name' => 'Never Have I Ever X',
			'projects.items.never_have_i_ever_x.description' => 'Party game app where players uncover surprising facts about each other through classic \'Never Have I Ever\' rounds. Reached 500K+ downloads on the back of share-driven viral loops.',
			'projects.items.never_have_i_ever_x.metric' => '500K+',
			'projects.items.never_have_i_ever_x.details' => 'Implemented the UI, hundreds of curated questions across multiple categories, and social sharing features. Integrated ad monetization (rewarded + interstitial) and analytics to optimize engagement and revenue per session.',
			'projects.items.booze.name' => 'Booze',
			'projects.items.booze.description' => 'Drinking party game with creative challenges, mini-games, and social mechanics designed for fun group gatherings. Reached 500K+ downloads through friend-driven discovery.',
			'projects.items.booze.metric' => '500K+',
			'projects.items.booze.details' => 'Implemented the UI, diverse challenge modes, customizable game rules, and group-play mechanics. Built smooth animations, ad monetization (rewarded + interstitial), and Firebase analytics to track engagement and session data.',
			'projects.items.vdx.name' => 'Truth or Dare X',
			'projects.items.vdx.description' => 'Party game app where friends challenge each other through classic \'Truth or Dare\' prompts. Reached 1M+ downloads through tight session loops and share-driven distribution.',
			'projects.items.vdx.metric' => '1M+',
			'projects.items.vdx.details' => 'Implemented the UI, hundreds of curated prompts across multiple categories, multiplayer session management, and social sharing features. Integrated ad monetization (rewarded + interstitial) and analytics to optimize engagement and revenue per session.',
			'projects.items.financo.name' => 'Financo',
			'projects.items.financo.description' => 'Cross-platform personal finance manager with AI-powered natural-language entry. Users describe expenses via text, receipt photos, or voice, and Vertex AI Gemini parses them into structured transactions for one-tap confirmation. Targets Android, iOS, and Web.',
			'projects.items.financo.details' => 'Built on Clean Architecture with feature-first layering (domain/data/presentation). Implemented multi-account management (checking + credit cards with linking), hierarchical categorization, cross-account transfers, recurring bills with auto-generation, CSV bulk import, and a dashboard with month/year filters, income-vs-expense summaries, category breakdowns, and evolution charts. Backed by Cloud Functions (Node.js 22 + TypeScript) running Vertex AI Gemini for the multimodal chat pipeline (text, image, voice transcription). Stack: flutter_bloc (Cubits + Blocs) • go_router • get_it • Firebase Auth + Google Sign-In • Cloud Firestore (sync) • Drift/SQLite (offline) • FCM + flutter_local_notifications (overdue-bill alerts) • fl_chart • dartz (Either<Failure, T>) • slang i18n. Spec-driven workflow with markdown contracts per feature. Layered testing with mocktail + bloc_test + fake_cloud_firestore. CI/CD via GitHub Actions signs and deploys Android + Web on every push to main.',
			'projects.items.harvest.name' => 'Harvest',
			'projects.items.harvest.award' => 'Production-Ready App 24-Hours-AI',
			'projects.items.harvest.description' => 'Fresh food e-commerce app connecting local farmers directly with their communities. Perishable-first product catalog with a fast, reliable shopping experience, shipped end-to-end in a 24-hour AI-assisted build.',
			'projects.items.harvest.details' => 'Architected with Clean Architecture and a feature-first structure across 13 features for long-term scalability and maintainability. Implemented Firebase Auth with email/password and Google Sign-In using platform-specific OAuth flows (popup on web, credential on mobile). Built a reusable UI component system with 8+ shared widgets and a complete Material 3 design system (Fresh Harvest palette, Poppins/Inter typography). Designed a centralized BLoC startup coordinator that pre-loads all data before navigation, eliminating per-page loading states. Structured a role-based admin system via a secure Firestore collection guarded by server-side security rules. Wrote 48+ unit tests covering domain entities, repository cache logic, and BLoC state machines with bloc_test and mocktail.',
			'projects.items.blu_bi.name' => 'Blu BI',
			'projects.items.blu_bi.description' => 'Business Intelligence app for tracking and visualizing financial data: revenue, expenses, and project-based results with charts, Income Statement (DRE) reports, and period analysis. Multiplatform (Android, iOS, Web, Windows, macOS, Linux).',
			'projects.items.blu_bi.details' => 'Built on Clean Architecture with self-contained feature modules (auth, finance, projects, company, personal) registered via GetX bindings. Implemented Google Sign-In with biometric (local_auth) protection, offline-first persistence via Isar, REST integration via Dio, and Firebase Remote Config for feature flags. Built dashboards and analytics with fl_chart: revenue/expense bar and pie charts, project-level financial breakdowns, money goals per category, and period-based reporting. Used Freezed + json_serializable for immutable models and get_it for dependency injection. Responsive layouts adapt cleanly from mobile to desktop. Stack: Flutter • GetX (state + navigation) • Firebase Auth + Google Sign-In • Firebase Remote Config • Dio • Isar • fl_chart • Freezed + json_serializable • get_it • local_auth.',
			'resume.title' => 'Resume',
			'resume.subtitle' => 'A summary of my professional experience and education',
			'resume.experience_title' => 'Professional Experience',
			'resume.education_title' => 'Education',
			'resume.download_resume' => 'Download Resume',
			'resume.experience.blu_studios.title' => 'Co-founder & Senior Flutter Engineer',
			'resume.experience.blu_studios.period' => '2019 – 2026',
			'resume.experience.blu_studios.location' => 'Remote',
			'resume.experience.blu_studios.points.0' => 'Built and maintained multiple mobile apps and games totaling ${_root.app.total_downloads} downloads worldwide.',
			'resume.experience.blu_studios.points.1' => 'Architected scalable Flutter applications supporting millions of users.',
			'resume.experience.blu_studios.points.2' => 'Executed deep performance optimization initiatives, reducing ANR rates from approximately 30% to below 2% and improving frame rendering stability on low-end Android devices.',
			'resume.experience.blu_studios.points.3' => 'Designed and implemented live ops systems (Battle Pass, Leaderboards, Events, Ranking Systems).',
			'resume.experience.blu_studios.points.4' => 'Improved D1 retention from approximately 25% to approximately 40% through UX performance tuning and data-driven iteration.',
			'resume.experience.blu_studios.points.5' => 'Reduced APK size by 45% through asset restructuring, rendering optimizations, and build configuration improvements.',
			'resume.experience.blu_studios.points.6' => 'Integrated Firebase (Analytics, Firestore, Remote Config, Crashlytics, Cloud Messaging).',
			'resume.experience.blu_studios.points.7' => 'Implemented monetization systems (Rewarded Ads, Interstitials, IAP) achieving high eCPM performance.',
			'resume.experience.blu_studios.points.8' => 'Co-owned the full product lifecycle: architecture, development, CI/CD, publishing, ASO, live ops, store compliance.',
			'resume.experience.blu_studios.points.9' => 'Co-led fully remote teams of up to 14 members.',
			'resume.experience.blu_studios.points.10' => 'Established partnerships with Wildlife Studios and Homa Games.',
			'resume.experience.vx_case.title' => 'Desktop Engineer',
			'resume.experience.vx_case.period' => 'Oct 2018 – Mar 2019',
			'resume.experience.vx_case.location' => 'Salvador, Brazil',
			'resume.experience.vx_case.points.0' => 'Developed a desktop application focused on user interface implementation using TypeScript, Angular, and VTEX.',
			'resume.experience.vx_case.points.1' => 'Built reusable UI components ensuring usability, scalability, and design consistency.',
			'resume.experience.vx_case.points.2' => 'Collaborated with senior engineers to integrate frontend features with backend services.',
			'resume.experience.tecall.title' => 'IT Support',
			'resume.experience.tecall.period' => 'Jan 2018 – Oct 2018',
			'resume.experience.tecall.location' => 'Salvador, Brazil',
			'resume.experience.tecall.points.0' => 'Provided technical support and infrastructure troubleshooting for corporate clients.',
			'resume.experience.tecall.points.1' => 'Assisted in system maintenance and hardware configuration.',
			'resume.experience.tecall.points.2' => 'Gained foundational experience in networking, system administration, and customer support.',
			'resume.education.ucsal.degree' => 'Bachelor\'s Degree in Software Engineering',
			'resume.education.ucsal.period' => '2017 – 2019',
			'resume.education.ucsal.location' => 'Salvador, Brazil',
			'resume.education.ucsal.points.0' => 'Emphasis on software development methodologies, object-oriented programming, data structures, algorithms, databases, and system architecture.',
			'resume.education.ucsal.points.1' => 'Gained experience in designing, developing, testing, and maintaining software applications using modern technologies and industry best practices.',
			'resume.education.ucsal.points.2' => 'Participated in collaborative projects and hands-on activities that strengthened problem-solving skills and prepared me to work effectively in team-based development environments.',
			'resume.education.senai_cimatec.degree' => 'Technical Course in Computer Networks',
			'resume.education.senai_cimatec.period' => '2017 – 2018',
			'resume.education.senai_cimatec.location' => 'Salvador, Brazil',
			'resume.education.senai_cimatec.points.0' => 'Focusing on the installation, configuration, administration, and maintenance of computer networks in both home and corporate environments.',
			'resume.education.senai_cimatec.points.1' => 'Throughout the training, I developed skills in network topologies, device connectivity, network infrastructure, communication protocols, and information security practices.',
			'resume.education.senai_cimatec.points.2' => 'The program included extensive hands-on lab experience, enabling me to implement network solutions effectively and apply industry-standard technical best practices.',
			'resume.education.all.degree' => 'Certificate in English Language',
			'resume.education.all.period' => '2013 – 2016',
			'resume.education.all.location' => 'Salvador, Brazil',
			'resume.education.all.points.0' => 'Intensive English language program with focus on grammar, reading, writing, listening and speaking skills. Prepared for advanced communication in academic and professional environments.',
			'skills.title' => 'Skills & Expertise',
			'skills.subtitle' => 'Technologies and tools I use to bring ideas to life',
			'skills.categories.core_engineering.title' => 'Core Engineering',
			'skills.categories.architecture_backend.title' => 'Architecture & Backend Systems',
			'skills.categories.devops_production.title' => 'DevOps, Observability & Production',
			'contact.title' => 'Let\'s Work Together',
			'contact.subtitle' => 'Have a project in mind or want to discuss opportunities? I\'m always open to new challenges and collaborations.',
			'contact.email' => 'Email',
			'contact.github' => 'GitHub',
			'contact.linkedin' => 'LinkedIn',
			'contact.footer' => '© 2026 ${_root.app.title}. Built with',
			'contact.flutter' => 'Flutter.',
			_ => null,
		};
	}
}
