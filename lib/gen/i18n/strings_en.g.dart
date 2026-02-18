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

	/// en: 'Guilherme Passos - Flutter Developer'
	String get title => 'Guilherme Passos - Flutter Developer';

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

	/// en: 'Senior Flutter Developer'
	String get role => 'Senior Flutter Developer';

	/// en: 'Flutter Developer & Mobile Entrepreneur with 7+ years crafting high-performance apps and games reaching 12M+ downloads worldwide.'
	String get description => 'Flutter Developer & Mobile Entrepreneur with 7+ years crafting high-performance apps and games reaching ${_root.app.total_downloads} downloads worldwide.';

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

	/// en: 'Senior Flutter Developer with over seven years of experience and seven years as an entrepreneur focused exclusively on mobile games and mobile applications.'
	String get bio1 => 'Senior Flutter Developer with over seven years of experience and seven years as an entrepreneur focused exclusively on mobile games and mobile applications.';

	/// en: 'I've implemented mobile products from scratch, including titles that surpassed 1M+ downloads, one of which was selected and awarded by the Google Play Indie Games Fund. Altogether, the apps and games I've built and maintained have reached 15M+ downloads worldwide.'
	String get bio2 => 'I\'ve implemented mobile products from scratch, including titles that surpassed 1M+ downloads, one of which was selected and awarded by the Google Play Indie Games Fund. Altogether, the apps and games I\'ve built and maintained have reached 15M+ downloads worldwide.';

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

	/// en: '© 2026 Guilherme Passos - Flutter Developer. Built with'
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
	late final TranslationsSkillsCategoriesMobileDevEn mobile_dev = TranslationsSkillsCategoriesMobileDevEn._(_root);
	late final TranslationsSkillsCategoriesBackendEn backend = TranslationsSkillsCategoriesBackendEn._(_root);
	late final TranslationsSkillsCategoriesLanguagesEn languages = TranslationsSkillsCategoriesLanguagesEn._(_root);
	late final TranslationsSkillsCategoriesToolsEn tools = TranslationsSkillsCategoriesToolsEn._(_root);
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

	/// en: 'First hybrid casual water-sort puzzle game on the market. Partnership with Wildlife Studios'
	String get description => 'First hybrid casual water-sort puzzle game on the market. Partnership with Wildlife Studios';

	/// en: '480K+'
	String get metric => '480K+';

	/// en: 'Indie Games Accelerator 2024'
	String get award => 'Indie Games Accelerator 2024';

	/// en: 'Implemented high-performance UI systems including animated tutorials, live-event mechanics (Battle Pass, Magic League, Treasure Hunts), and a scalable monetization framework with rewarded ads, interstitials, and IAP. Integrated Firebase Analytics, Remote Config for A/B testing, and Crashlytics for real-time monitoring.'
	String get details => 'Implemented high-performance UI systems including animated tutorials, live-event mechanics (Battle Pass, Magic League, Treasure Hunts), and a scalable monetization framework with rewarded ads, interstitials, and IAP. Integrated Firebase Analytics, Remote Config for A/B testing, and Crashlytics for real-time monitoring.';
}

// Path: projects.items.rabit
class TranslationsProjectsItemsRabitEn {
	TranslationsProjectsItemsRabitEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Rabit'
	String get name => 'Rabit';

	/// en: 'Gamified habit tracking app where users grow virtual plants by completing daily tasks. Ranked 2nd as App of the Year 2021 on Google Play Brazil.'
	String get description => 'Gamified habit tracking app where users grow virtual plants by completing daily tasks. Ranked 2nd as App of the Year 2021 on Google Play Brazil.';

	/// en: '5M+'
	String get metric => '5M+';

	/// en: 'Google Play Best of 2021'
	String get award => 'Google Play Best of 2021';

	/// en: 'Implemented push/local notifications, cloud sync with Firebase Firestore, streak tracking, and detailed analytics. Designed custom animations, high-performance UI systems and micro-interactions that boosted user retention.'
	String get details => 'Implemented push/local notifications, cloud sync with Firebase Firestore, streak tracking, and detailed analytics. Designed custom animations, high-performance UI systems and micro-interactions that boosted user retention.';
}

// Path: projects.items.cups
class TranslationsProjectsItemsCupsEn {
	TranslationsProjectsItemsCupsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cups'
	String get name => 'Cups';

	/// en: 'Water sort puzzle game surpassing 4.5M+ downloads with strong traction in the US market. Partnership with Homa Games'
	String get description => 'Water sort puzzle game surpassing 4.5M+ downloads with strong traction in the US market. Partnership with Homa Games';

	/// en: '4.5M+'
	String get metric => '4.5M+';

	/// en: 'Implemented the complete UI layer, monetization systems. Co-led the performance optimization efforts that reduced frame build times and improved user experience on low-end devices.'
	String get details => 'Implemented the complete UI layer, monetization systems. Co-led the performance optimization efforts that reduced frame build times and improved user experience on low-end devices.';
}

// Path: projects.items.farm_vs_aliens
class TranslationsProjectsItemsFarmVsAliensEn {
	TranslationsProjectsItemsFarmVsAliensEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Farm vs Aliens'
	String get name => 'Farm vs Aliens';

	/// en: 'A merge tower defense game where players defend their farm from alien invaders by merging and upgrading towers.'
	String get description => 'A merge tower defense game where players defend their farm from alien invaders by merging and upgrading towers.';

	/// en: 'Indie Games Fund 2023'
	String get award => 'Indie Games Fund 2023';

	/// en: 'Led product direction and game design for this merge tower defense game. Defined the core gameplay loop combining merge mechanics with strategic tower defense.'
	String get details => 'Led product direction and game design for this merge tower defense game. Defined the core gameplay loop combining merge mechanics with strategic tower defense.';
}

// Path: projects.items.capy
class TranslationsProjectsItemsCapyEn {
	TranslationsProjectsItemsCapyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Capy: Self-Care Pet'
	String get name => 'Capy: Self-Care Pet';

	/// en: 'Self-care companion app with a virtual pet mechanic. Users maintain their well-being through daily tasks and caring for their capybara.'
	String get description => 'Self-care companion app with a virtual pet mechanic. Users maintain their well-being through daily tasks and caring for their capybara.';

	/// en: 'Implemented habit tracking, mood journaling, and pet evolution mechanics. Integrated push notifications for daily reminders and Firebase for user data persistence.'
	String get details => 'Implemented habit tracking, mood journaling, and pet evolution mechanics. Integrated push notifications for daily reminders and Firebase for user data persistence.';
}

// Path: projects.items.drop_merge
class TranslationsProjectsItemsDropMergeEn {
	TranslationsProjectsItemsDropMergeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Drop & Merge'
	String get name => 'Drop & Merge';

	/// en: 'Addictive drop and merge puzzle game combining strategic placement with satisfying merge mechanics for an engaging casual experience.'
	String get description => 'Addictive drop and merge puzzle game combining strategic placement with satisfying merge mechanics for an engaging casual experience.';

	/// en: 'Implemented the complete UI layer'
	String get details => 'Implemented the complete UI layer';
}

// Path: projects.items.never_have_i_ever_x
class TranslationsProjectsItemsNeverHaveIEverXEn {
	TranslationsProjectsItemsNeverHaveIEverXEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Never Have I Ever X'
	String get name => 'Never Have I Ever X';

	/// en: 'A fun party game app where players discover surprising facts about each other through classic 'Never Have I Ever' questions.'
	String get description => 'A fun party game app where players discover surprising facts about each other through classic \'Never Have I Ever\' questions.';

	/// en: '500K+'
	String get metric => '500K+';

	/// en: 'Implemented UI and hundreds of curated questions across multiple categories, and social sharing features. Integrated ad monetization and analytics to optimize engagement and revenue.'
	String get details => 'Implemented UI and hundreds of curated questions across multiple categories, and social sharing features. Integrated ad monetization and analytics to optimize engagement and revenue.';
}

// Path: projects.items.booze
class TranslationsProjectsItemsBoozeEn {
	TranslationsProjectsItemsBoozeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Booze'
	String get name => 'Booze';

	/// en: 'A drinking game app with creative challenges, mini-games, and social dynamics designed for fun group gatherings.'
	String get description => 'A drinking game app with creative challenges, mini-games, and social dynamics designed for fun group gatherings.';

	/// en: '500K+'
	String get metric => '500K+';

	/// en: 'Implemented UI and diverse challenge modes, customizable game rules, and group play mechanics. Implemented smooth animations, ad monetization, and Firebase analytics for tracking user engagement and session data.'
	String get details => 'Implemented UI and diverse challenge modes, customizable game rules, and group play mechanics. Implemented smooth animations, ad monetization, and Firebase analytics for tracking user engagement and session data.';
}

// Path: projects.items.vdx
class TranslationsProjectsItemsVdxEn {
	TranslationsProjectsItemsVdxEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Truth or Dare X'
	String get name => 'Truth or Dare X';

	/// en: 'A fun party game app where players discover surprising facts about each other through classic 'Truth or Dare' questions.'
	String get description => 'A fun party game app where players discover surprising facts about each other through classic \'Truth or Dare\' questions.';

	/// en: '1M+'
	String get metric => '1M+';

	/// en: 'Implemented UI and hundreds of curated questions across multiple categories, multiplayer session management, and social sharing features. Integrated ad monetization and analytics to optimize engagement and revenue.'
	String get details => 'Implemented UI and hundreds of curated questions across multiple categories, multiplayer session management, and social sharing features. Integrated ad monetization and analytics to optimize engagement and revenue.';
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
		'Architected scalable systems supporting millions of users, including real-time leaderboards, live events, and ranking systems.',
		'Co-owned the full mobile product lifecycle: architecture, development, testing, CI/CD, publishing, ASO, monetization, live ops, and store compliance.',
		'Integrated backend services using Firebase (Full Suite), GraphQL APIs, and Node.js.',
		'Designed and optimized monetization systems achieving consistently high eCPM performance.',
		'Co-led fully remote teams of up to 14 people.',
		'Established partnerships with Wildlife Studios and Homa Games.',
	];
}

// Path: resume.experience.vx_case
class TranslationsResumeExperienceVxCaseEn {
	TranslationsResumeExperienceVxCaseEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Desktop Developer'
	String get title => 'Desktop Developer';

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

// Path: skills.categories.mobile_dev
class TranslationsSkillsCategoriesMobileDevEn {
	TranslationsSkillsCategoriesMobileDevEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Mobile Development'
	String get title => 'Mobile Development';

	List<String> get skills => [
		'Flutter',
		'Dart',
		'Riverpod',
		'Bloc',
		'MobX',
		'MVVM',
		'Clean Architecture',
		'TDD',
		'Native Plugins',
	];
}

// Path: skills.categories.backend
class TranslationsSkillsCategoriesBackendEn {
	TranslationsSkillsCategoriesBackendEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Backend & Cloud'
	String get title => 'Backend & Cloud';

	List<String> get skills => [
		'Firebase (Full Suite)',
		'Node.js',
		'GraphQL',
		'REST APIs',
		'SQL',
		'NoSQL',
	];
}

// Path: skills.categories.languages
class TranslationsSkillsCategoriesLanguagesEn {
	TranslationsSkillsCategoriesLanguagesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Languages'
	String get title => 'Languages';

	List<String> get skills => [
		'Dart',
		'Java',
		'Kotlin',
		'JavaScript',
		'TypeScript',
	];
}

// Path: skills.categories.tools
class TranslationsSkillsCategoriesToolsEn {
	TranslationsSkillsCategoriesToolsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Tools & Product'
	String get title => 'Tools & Product';

	List<String> get skills => [
		'Git',
		'CI/CD',
		'Figma',
		'ASO',
		'Monetization',
		'Codemagic',
		'GitHub Actions',
	];
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => 'Guilherme Passos - Flutter Developer',
			'app.total_downloads' => '12M+',
			'nav.about' => 'About',
			'nav.projects' => 'Projects',
			'nav.experience' => 'Experience',
			'nav.skills' => 'Skills',
			'nav.contact' => 'Contact',
			'hero.name' => 'Guilherme\nPassos',
			'hero.role' => 'Senior Flutter Developer',
			'hero.description' => 'Flutter Developer & Mobile Entrepreneur with 7+ years crafting high-performance apps and games reaching ${_root.app.total_downloads} downloads worldwide.',
			'hero.explore_projects' => 'Explore Projects',
			'hero.get_in_touch' => 'Get In Touch',
			'about.title' => 'About Me',
			'about.subtitle' => 'Building digital products that scale',
			'about.bio1' => 'Senior Flutter Developer with over seven years of experience and seven years as an entrepreneur focused exclusively on mobile games and mobile applications.',
			'about.bio2' => 'I\'ve implemented mobile products from scratch, including titles that surpassed 1M+ downloads, one of which was selected and awarded by the Google Play Indie Games Fund. Altogether, the apps and games I\'ve built and maintained have reached 15M+ downloads worldwide.',
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
			'projects.items.magic_sort.name' => 'Magic Sort',
			'projects.items.magic_sort.description' => 'First hybrid casual water-sort puzzle game on the market. Partnership with Wildlife Studios',
			'projects.items.magic_sort.metric' => '480K+',
			'projects.items.magic_sort.award' => 'Indie Games Accelerator 2024',
			'projects.items.magic_sort.details' => 'Implemented high-performance UI systems including animated tutorials, live-event mechanics (Battle Pass, Magic League, Treasure Hunts), and a scalable monetization framework with rewarded ads, interstitials, and IAP. Integrated Firebase Analytics, Remote Config for A/B testing, and Crashlytics for real-time monitoring.',
			'projects.items.rabit.name' => 'Rabit',
			'projects.items.rabit.description' => 'Gamified habit tracking app where users grow virtual plants by completing daily tasks. Ranked 2nd as App of the Year 2021 on Google Play Brazil.',
			'projects.items.rabit.metric' => '5M+',
			'projects.items.rabit.award' => 'Google Play Best of 2021',
			'projects.items.rabit.details' => 'Implemented push/local notifications, cloud sync with Firebase Firestore, streak tracking, and detailed analytics. Designed custom animations, high-performance UI systems and micro-interactions that boosted user retention.',
			'projects.items.cups.name' => 'Cups',
			'projects.items.cups.description' => 'Water sort puzzle game surpassing 4.5M+ downloads with strong traction in the US market. Partnership with Homa Games',
			'projects.items.cups.metric' => '4.5M+',
			'projects.items.cups.details' => 'Implemented the complete UI layer, monetization systems. Co-led the performance optimization efforts that reduced frame build times and improved user experience on low-end devices.',
			'projects.items.farm_vs_aliens.name' => 'Farm vs Aliens',
			'projects.items.farm_vs_aliens.description' => 'A merge tower defense game where players defend their farm from alien invaders by merging and upgrading towers.',
			'projects.items.farm_vs_aliens.award' => 'Indie Games Fund 2023',
			'projects.items.farm_vs_aliens.details' => 'Led product direction and game design for this merge tower defense game. Defined the core gameplay loop combining merge mechanics with strategic tower defense.',
			'projects.items.capy.name' => 'Capy: Self-Care Pet',
			'projects.items.capy.description' => 'Self-care companion app with a virtual pet mechanic. Users maintain their well-being through daily tasks and caring for their capybara.',
			'projects.items.capy.details' => 'Implemented habit tracking, mood journaling, and pet evolution mechanics. Integrated push notifications for daily reminders and Firebase for user data persistence.',
			'projects.items.drop_merge.name' => 'Drop & Merge',
			'projects.items.drop_merge.description' => 'Addictive drop and merge puzzle game combining strategic placement with satisfying merge mechanics for an engaging casual experience.',
			'projects.items.drop_merge.details' => 'Implemented the complete UI layer',
			'projects.items.never_have_i_ever_x.name' => 'Never Have I Ever X',
			'projects.items.never_have_i_ever_x.description' => 'A fun party game app where players discover surprising facts about each other through classic \'Never Have I Ever\' questions.',
			'projects.items.never_have_i_ever_x.metric' => '500K+',
			'projects.items.never_have_i_ever_x.details' => 'Implemented UI and hundreds of curated questions across multiple categories, and social sharing features. Integrated ad monetization and analytics to optimize engagement and revenue.',
			'projects.items.booze.name' => 'Booze',
			'projects.items.booze.description' => 'A drinking game app with creative challenges, mini-games, and social dynamics designed for fun group gatherings.',
			'projects.items.booze.metric' => '500K+',
			'projects.items.booze.details' => 'Implemented UI and diverse challenge modes, customizable game rules, and group play mechanics. Implemented smooth animations, ad monetization, and Firebase analytics for tracking user engagement and session data.',
			'projects.items.vdx.name' => 'Truth or Dare X',
			'projects.items.vdx.description' => 'A fun party game app where players discover surprising facts about each other through classic \'Truth or Dare\' questions.',
			'projects.items.vdx.metric' => '1M+',
			'projects.items.vdx.details' => 'Implemented UI and hundreds of curated questions across multiple categories, multiplayer session management, and social sharing features. Integrated ad monetization and analytics to optimize engagement and revenue.',
			'resume.title' => 'Resume',
			'resume.subtitle' => 'A summary of my professional experience and education',
			'resume.experience_title' => 'Professional Experience',
			'resume.education_title' => 'Education',
			'resume.download_resume' => 'Download Resume',
			'resume.experience.blu_studios.title' => 'Co-founder & Senior Flutter Engineer',
			'resume.experience.blu_studios.period' => '2019 – 2026',
			'resume.experience.blu_studios.location' => 'Remote',
			'resume.experience.blu_studios.points.0' => 'Built and maintained multiple mobile apps and games totaling ${_root.app.total_downloads} downloads worldwide.',
			'resume.experience.blu_studios.points.1' => 'Architected scalable systems supporting millions of users, including real-time leaderboards, live events, and ranking systems.',
			'resume.experience.blu_studios.points.2' => 'Co-owned the full mobile product lifecycle: architecture, development, testing, CI/CD, publishing, ASO, monetization, live ops, and store compliance.',
			'resume.experience.blu_studios.points.3' => 'Integrated backend services using Firebase (Full Suite), GraphQL APIs, and Node.js.',
			'resume.experience.blu_studios.points.4' => 'Designed and optimized monetization systems achieving consistently high eCPM performance.',
			'resume.experience.blu_studios.points.5' => 'Co-led fully remote teams of up to 14 people.',
			'resume.experience.blu_studios.points.6' => 'Established partnerships with Wildlife Studios and Homa Games.',
			'resume.experience.vx_case.title' => 'Desktop Developer',
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
			'skills.categories.mobile_dev.title' => 'Mobile Development',
			'skills.categories.mobile_dev.skills.0' => 'Flutter',
			'skills.categories.mobile_dev.skills.1' => 'Dart',
			'skills.categories.mobile_dev.skills.2' => 'Riverpod',
			'skills.categories.mobile_dev.skills.3' => 'Bloc',
			'skills.categories.mobile_dev.skills.4' => 'MobX',
			'skills.categories.mobile_dev.skills.5' => 'MVVM',
			'skills.categories.mobile_dev.skills.6' => 'Clean Architecture',
			'skills.categories.mobile_dev.skills.7' => 'TDD',
			'skills.categories.mobile_dev.skills.8' => 'Native Plugins',
			'skills.categories.backend.title' => 'Backend & Cloud',
			'skills.categories.backend.skills.0' => 'Firebase (Full Suite)',
			'skills.categories.backend.skills.1' => 'Node.js',
			'skills.categories.backend.skills.2' => 'GraphQL',
			'skills.categories.backend.skills.3' => 'REST APIs',
			'skills.categories.backend.skills.4' => 'SQL',
			'skills.categories.backend.skills.5' => 'NoSQL',
			'skills.categories.languages.title' => 'Languages',
			'skills.categories.languages.skills.0' => 'Dart',
			'skills.categories.languages.skills.1' => 'Java',
			'skills.categories.languages.skills.2' => 'Kotlin',
			'skills.categories.languages.skills.3' => 'JavaScript',
			'skills.categories.languages.skills.4' => 'TypeScript',
			'skills.categories.tools.title' => 'Tools & Product',
			'skills.categories.tools.skills.0' => 'Git',
			'skills.categories.tools.skills.1' => 'CI/CD',
			'skills.categories.tools.skills.2' => 'Figma',
			'skills.categories.tools.skills.3' => 'ASO',
			'skills.categories.tools.skills.4' => 'Monetization',
			'skills.categories.tools.skills.5' => 'Codemagic',
			'skills.categories.tools.skills.6' => 'GitHub Actions',
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
