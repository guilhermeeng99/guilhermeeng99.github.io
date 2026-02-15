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
	late final TranslationsExperienceEn experience = TranslationsExperienceEn._(_root);
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

	/// en: 'Flutter Developer'
	String get role => 'Flutter Developer';

	/// en: 'Flutter Developer & Mobile Entrepreneur with 5+ years crafting high-performance apps and games reaching 15M+ downloads worldwide.'
	String get description => 'Flutter Developer & Mobile Entrepreneur with 5+ years crafting high-performance apps and games reaching 15M+ downloads worldwide.';

	/// en: 'Explore Projects'
	String get exploreProjects => 'Explore Projects';

	/// en: 'Get In Touch'
	String get getInTouch => 'Get In Touch';
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

	/// en: 'Pleno Flutter Developer with over five years of experience and seven years as an entrepreneur focused exclusively on mobile games and mobile applications.'
	String get bio1 => 'Pleno Flutter Developer with over five years of experience and seven years as an entrepreneur focused exclusively on mobile games and mobile applications.';

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

	late final TranslationsProjectsItemsEn items = TranslationsProjectsItemsEn._(_root);
}

// Path: experience
class TranslationsExperienceEn {
	TranslationsExperienceEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Experience'
	String get title => 'Experience';

	/// en: 'My professional journey so far'
	String get subtitle => 'My professional journey so far';

	late final TranslationsExperienceItemsEn items = TranslationsExperienceItemsEn._(_root);
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
	late final TranslationsSkillsAwardsEn awards = TranslationsSkillsAwardsEn._(_root);
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
	late final TranslationsProjectsItemsMagicSortEn magicSort = TranslationsProjectsItemsMagicSortEn._(_root);
	late final TranslationsProjectsItemsRabitEn rabit = TranslationsProjectsItemsRabitEn._(_root);
	late final TranslationsProjectsItemsCupsEn cups = TranslationsProjectsItemsCupsEn._(_root);
	late final TranslationsProjectsItemsFarmVsAliensEn farmVsAliens = TranslationsProjectsItemsFarmVsAliensEn._(_root);
	late final TranslationsProjectsItemsCapyEn capy = TranslationsProjectsItemsCapyEn._(_root);
	late final TranslationsProjectsItemsDropMergeEn dropMerge = TranslationsProjectsItemsDropMergeEn._(_root);
}

// Path: experience.items
class TranslationsExperienceItemsEn {
	TranslationsExperienceItemsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsExperienceItemsBluStudiosEn bluStudios = TranslationsExperienceItemsBluStudiosEn._(_root);
	late final TranslationsExperienceItemsVxCaseEn vxCase = TranslationsExperienceItemsVxCaseEn._(_root);
	late final TranslationsExperienceItemsTecallEn tecall = TranslationsExperienceItemsTecallEn._(_root);
}

// Path: skills.categories
class TranslationsSkillsCategoriesEn {
	TranslationsSkillsCategoriesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsSkillsCategoriesMobileDevEn mobileDev = TranslationsSkillsCategoriesMobileDevEn._(_root);
	late final TranslationsSkillsCategoriesBackendEn backend = TranslationsSkillsCategoriesBackendEn._(_root);
	late final TranslationsSkillsCategoriesLanguagesEn languages = TranslationsSkillsCategoriesLanguagesEn._(_root);
	late final TranslationsSkillsCategoriesToolsEn tools = TranslationsSkillsCategoriesToolsEn._(_root);
}

// Path: skills.awards
class TranslationsSkillsAwardsEn {
	TranslationsSkillsAwardsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Awards & Recognition'
	String get title => 'Awards & Recognition';

	late final TranslationsSkillsAwardsGooglePlayEn googlePlay = TranslationsSkillsAwardsGooglePlayEn._(_root);
	late final TranslationsSkillsAwardsIndieFundEn indieFund = TranslationsSkillsAwardsIndieFundEn._(_root);
	late final TranslationsSkillsAwardsAcceleratorEn accelerator = TranslationsSkillsAwardsAcceleratorEn._(_root);
}

// Path: about.stats.downloads
class TranslationsAboutStatsDownloadsEn {
	TranslationsAboutStatsDownloadsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '15M+'
	String get value => '15M+';

	/// en: 'Downloads'
	String get label => 'Downloads';
}

// Path: about.stats.experience
class TranslationsAboutStatsExperienceEn {
	TranslationsAboutStatsExperienceEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '5+'
	String get value => '5+';

	/// en: 'Years Experience'
	String get label => 'Years Experience';
}

// Path: about.stats.products
class TranslationsAboutStatsProductsEn {
	TranslationsAboutStatsProductsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '7+'
	String get value => '7+';

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

// Path: projects.items.magicSort
class TranslationsProjectsItemsMagicSortEn {
	TranslationsProjectsItemsMagicSortEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Magic Sort'
	String get name => 'Magic Sort';

	/// en: 'Hybrid Casual Puzzle · 2024 – Present'
	String get category => 'Hybrid Casual Puzzle · 2024 – Present';

	/// en: 'First hybrid casual water-sort puzzle game on the market. Designed complex/high-performance UI systems, monetization flows, and live-event mechanics.'
	String get description => 'First hybrid casual water-sort puzzle game on the market. Designed complex/high-performance UI systems, monetization flows, and live-event mechanics.';

	/// en: '480K+ downloads'
	String get badge => '480K+ downloads';

	/// en: '480K+'
	String get metric => '480K+';
}

// Path: projects.items.rabit
class TranslationsProjectsItemsRabitEn {
	TranslationsProjectsItemsRabitEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Rabit'
	String get name => 'Rabit';

	/// en: 'Gamified Habit Tracker · 2020 – 2022'
	String get category => 'Gamified Habit Tracker · 2020 – 2022';

	/// en: 'Google Play Best of 2021 – App of the Year Nominee. Implemented gamified habit tracking with notifications, cloud sync, and analytics.'
	String get description => 'Google Play Best of 2021 – App of the Year Nominee. Implemented gamified habit tracking with notifications, cloud sync, and analytics.';

	/// en: 'Best of 2021'
	String get badge => 'Best of 2021';

	/// en: '3.5M+'
	String get metric => '3.5M+';
}

// Path: projects.items.cups
class TranslationsProjectsItemsCupsEn {
	TranslationsProjectsItemsCupsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cups'
	String get name => 'Cups';

	/// en: 'Casual Puzzle · 2020 – 2023'
	String get category => 'Casual Puzzle · 2020 – 2023';

	/// en: 'Water sort puzzle game surpassing 4.5M+ downloads with strong traction in the US market. Implemented UIs, monetization systems, and full ads integration.'
	String get description => 'Water sort puzzle game surpassing 4.5M+ downloads with strong traction in the US market. Implemented UIs, monetization systems, and full ads integration.';

	/// en: '4.5M+'
	String get metric => '4.5M+';
}

// Path: projects.items.farmVsAliens
class TranslationsProjectsItemsFarmVsAliensEn {
	TranslationsProjectsItemsFarmVsAliensEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Farm vs Aliens'
	String get name => 'Farm vs Aliens';

	/// en: 'Tower Defense · 2023 – 2024'
	String get category => 'Tower Defense · 2023 – 2024';

	/// en: 'Winner of the Google Play Indie Games Fund 2024. Led product direction, game design, and monetization strategy for this merge tower defense game.'
	String get description => 'Winner of the Google Play Indie Games Fund 2024. Led product direction, game design, and monetization strategy for this merge tower defense game.';

	/// en: 'Indie Fund Winner'
	String get badge => 'Indie Fund Winner';
}

// Path: projects.items.capy
class TranslationsProjectsItemsCapyEn {
	TranslationsProjectsItemsCapyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Capy: Self-Care Pet'
	String get name => 'Capy: Self-Care Pet';

	/// en: 'Wellness App'
	String get category => 'Wellness App';

	/// en: 'Self-care companion app with a virtual pet mechanic. Users maintain their well-being through daily tasks and caring for their capybara.'
	String get description => 'Self-care companion app with a virtual pet mechanic. Users maintain their well-being through daily tasks and caring for their capybara.';
}

// Path: projects.items.dropMerge
class TranslationsProjectsItemsDropMergeEn {
	TranslationsProjectsItemsDropMergeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Drop & Merge'
	String get name => 'Drop & Merge';

	/// en: 'Casual Puzzle'
	String get category => 'Casual Puzzle';

	/// en: 'Addictive drop and merge puzzle game combining strategic placement with satisfying merge mechanics for an engaging casual experience.'
	String get description => 'Addictive drop and merge puzzle game combining strategic placement with satisfying merge mechanics for an engaging casual experience.';
}

// Path: experience.items.bluStudios
class TranslationsExperienceItemsBluStudiosEn {
	TranslationsExperienceItemsBluStudiosEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Partner & Pleno Flutter Engineer'
	String get title => 'Partner & Pleno Flutter Engineer';

	/// en: 'Blu Studios'
	String get company => 'Blu Studios';

	/// en: '2019 – 2026'
	String get period => '2019 – 2026';

	/// en: 'Remote'
	String get location => 'Remote';

	List<String> get points => [
		'Built and maintained multiple mobile apps and games totaling 15M+ downloads worldwide.',
		'Architected scalable systems supporting millions of users, including real-time leaderboards, live events, and ranking systems.',
		'Owned the full mobile product lifecycle: architecture, development, testing, CI/CD, publishing, ASO, monetization, live ops, and store compliance.',
		'Integrated backend services using Firebase (Full Suite), GraphQL APIs, and Node.js.',
		'Designed and optimized monetization systems achieving consistently high eCPM performance.',
		'Led fully remote teams of up to 14 people.',
		'Established partnerships with Wildlife Studios and Homa Games.',
	];
}

// Path: experience.items.vxCase
class TranslationsExperienceItemsVxCaseEn {
	TranslationsExperienceItemsVxCaseEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Junior Desktop Developer'
	String get title => 'Junior Desktop Developer';

	/// en: 'VX Case'
	String get company => 'VX Case';

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

// Path: experience.items.tecall
class TranslationsExperienceItemsTecallEn {
	TranslationsExperienceItemsTecallEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'IT Support Intern'
	String get title => 'IT Support Intern';

	/// en: 'Tecall Consultoria'
	String get company => 'Tecall Consultoria';

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

// Path: skills.categories.mobileDev
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

// Path: skills.awards.googlePlay
class TranslationsSkillsAwardsGooglePlayEn {
	TranslationsSkillsAwardsGooglePlayEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Google Play Best of 2021'
	String get title => 'Google Play Best of 2021';

	/// en: 'App of the Year Nominee (Rabit)'
	String get subtitle => 'App of the Year Nominee (Rabit)';
}

// Path: skills.awards.indieFund
class TranslationsSkillsAwardsIndieFundEn {
	TranslationsSkillsAwardsIndieFundEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Indie Games Fund 2023'
	String get title => 'Indie Games Fund 2023';

	/// en: 'Winner (Farm vs Aliens)'
	String get subtitle => 'Winner (Farm vs Aliens)';
}

// Path: skills.awards.accelerator
class TranslationsSkillsAwardsAcceleratorEn {
	TranslationsSkillsAwardsAcceleratorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Indie Games Accelerator 2024'
	String get title => 'Indie Games Accelerator 2024';

	/// en: 'Graduate'
	String get subtitle => 'Graduate';
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
			'nav.about' => 'About',
			'nav.projects' => 'Projects',
			'nav.experience' => 'Experience',
			'nav.skills' => 'Skills',
			'nav.contact' => 'Contact',
			'hero.name' => 'Guilherme\nPassos',
			'hero.role' => 'Flutter Developer',
			'hero.description' => 'Flutter Developer & Mobile Entrepreneur with 5+ years crafting high-performance apps and games reaching 15M+ downloads worldwide.',
			'hero.exploreProjects' => 'Explore Projects',
			'hero.getInTouch' => 'Get In Touch',
			'about.title' => 'About Me',
			'about.subtitle' => 'Building digital products that scale',
			'about.bio1' => 'Pleno Flutter Developer with over five years of experience and seven years as an entrepreneur focused exclusively on mobile games and mobile applications.',
			'about.bio2' => 'I\'ve implemented mobile products from scratch, including titles that surpassed 1M+ downloads, one of which was selected and awarded by the Google Play Indie Games Fund. Altogether, the apps and games I\'ve built and maintained have reached 15M+ downloads worldwide.',
			'about.bio3' => 'I specialize in scalable architectures, long-term code maintainability, and high-performance mobile applications. My expertise spans multiple state management solutions (Riverpod, Bloc, MobX), native plugin integration, and the full Firebase ecosystem.',
			'about.stats.downloads.value' => '15M+',
			'about.stats.downloads.label' => 'Downloads',
			'about.stats.experience.value' => '5+',
			'about.stats.experience.label' => 'Years Experience',
			'about.stats.products.value' => '7+',
			'about.stats.products.label' => 'Products Shipped',
			'about.stats.teamSize.value' => '14',
			'about.stats.teamSize.label' => 'Max Team Size Co-led',
			'projects.title' => 'Featured Projects',
			'projects.subtitle' => 'Real-world products across games and mobile apps',
			'projects.items.magicSort.name' => 'Magic Sort',
			'projects.items.magicSort.category' => 'Hybrid Casual Puzzle · 2024 – Present',
			'projects.items.magicSort.description' => 'First hybrid casual water-sort puzzle game on the market. Designed complex/high-performance UI systems, monetization flows, and live-event mechanics.',
			'projects.items.magicSort.badge' => '480K+ downloads',
			'projects.items.magicSort.metric' => '480K+',
			'projects.items.rabit.name' => 'Rabit',
			'projects.items.rabit.category' => 'Gamified Habit Tracker · 2020 – 2022',
			'projects.items.rabit.description' => 'Google Play Best of 2021 – App of the Year Nominee. Implemented gamified habit tracking with notifications, cloud sync, and analytics.',
			'projects.items.rabit.badge' => 'Best of 2021',
			'projects.items.rabit.metric' => '3.5M+',
			'projects.items.cups.name' => 'Cups',
			'projects.items.cups.category' => 'Casual Puzzle · 2020 – 2023',
			'projects.items.cups.description' => 'Water sort puzzle game surpassing 4.5M+ downloads with strong traction in the US market. Implemented UIs, monetization systems, and full ads integration.',
			'projects.items.cups.metric' => '4.5M+',
			'projects.items.farmVsAliens.name' => 'Farm vs Aliens',
			'projects.items.farmVsAliens.category' => 'Tower Defense · 2023 – 2024',
			'projects.items.farmVsAliens.description' => 'Winner of the Google Play Indie Games Fund 2024. Led product direction, game design, and monetization strategy for this merge tower defense game.',
			'projects.items.farmVsAliens.badge' => 'Indie Fund Winner',
			'projects.items.capy.name' => 'Capy: Self-Care Pet',
			'projects.items.capy.category' => 'Wellness App',
			'projects.items.capy.description' => 'Self-care companion app with a virtual pet mechanic. Users maintain their well-being through daily tasks and caring for their capybara.',
			'projects.items.dropMerge.name' => 'Drop & Merge',
			'projects.items.dropMerge.category' => 'Casual Puzzle',
			'projects.items.dropMerge.description' => 'Addictive drop and merge puzzle game combining strategic placement with satisfying merge mechanics for an engaging casual experience.',
			'experience.title' => 'Experience',
			'experience.subtitle' => 'My professional journey so far',
			'experience.items.bluStudios.title' => 'Partner & Pleno Flutter Engineer',
			'experience.items.bluStudios.company' => 'Blu Studios',
			'experience.items.bluStudios.period' => '2019 – 2026',
			'experience.items.bluStudios.location' => 'Remote',
			'experience.items.bluStudios.points.0' => 'Built and maintained multiple mobile apps and games totaling 15M+ downloads worldwide.',
			'experience.items.bluStudios.points.1' => 'Architected scalable systems supporting millions of users, including real-time leaderboards, live events, and ranking systems.',
			'experience.items.bluStudios.points.2' => 'Owned the full mobile product lifecycle: architecture, development, testing, CI/CD, publishing, ASO, monetization, live ops, and store compliance.',
			'experience.items.bluStudios.points.3' => 'Integrated backend services using Firebase (Full Suite), GraphQL APIs, and Node.js.',
			'experience.items.bluStudios.points.4' => 'Designed and optimized monetization systems achieving consistently high eCPM performance.',
			'experience.items.bluStudios.points.5' => 'Led fully remote teams of up to 14 people.',
			'experience.items.bluStudios.points.6' => 'Established partnerships with Wildlife Studios and Homa Games.',
			'experience.items.vxCase.title' => 'Junior Desktop Developer',
			'experience.items.vxCase.company' => 'VX Case',
			'experience.items.vxCase.period' => 'Oct 2018 – Mar 2019',
			'experience.items.vxCase.location' => 'Salvador, Brazil',
			'experience.items.vxCase.points.0' => 'Developed a desktop application focused on user interface implementation using TypeScript, Angular, and VTEX.',
			'experience.items.vxCase.points.1' => 'Built reusable UI components ensuring usability, scalability, and design consistency.',
			'experience.items.vxCase.points.2' => 'Collaborated with senior engineers to integrate frontend features with backend services.',
			'experience.items.tecall.title' => 'IT Support Intern',
			'experience.items.tecall.company' => 'Tecall Consultoria',
			'experience.items.tecall.period' => 'Jan 2018 – Oct 2018',
			'experience.items.tecall.location' => 'Salvador, Brazil',
			'experience.items.tecall.points.0' => 'Provided technical support and infrastructure troubleshooting for corporate clients.',
			'experience.items.tecall.points.1' => 'Assisted in system maintenance and hardware configuration.',
			'experience.items.tecall.points.2' => 'Gained foundational experience in networking, system administration, and customer support.',
			'skills.title' => 'Skills & Expertise',
			'skills.subtitle' => 'Technologies and tools I use to bring ideas to life',
			'skills.categories.mobileDev.title' => 'Mobile Development',
			'skills.categories.mobileDev.skills.0' => 'Flutter',
			'skills.categories.mobileDev.skills.1' => 'Dart',
			'skills.categories.mobileDev.skills.2' => 'Riverpod',
			'skills.categories.mobileDev.skills.3' => 'Bloc',
			'skills.categories.mobileDev.skills.4' => 'MobX',
			'skills.categories.mobileDev.skills.5' => 'MVVM',
			'skills.categories.mobileDev.skills.6' => 'Clean Architecture',
			'skills.categories.mobileDev.skills.7' => 'TDD',
			'skills.categories.mobileDev.skills.8' => 'Native Plugins',
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
			'skills.awards.title' => 'Awards & Recognition',
			'skills.awards.googlePlay.title' => 'Google Play Best of 2021',
			'skills.awards.googlePlay.subtitle' => 'App of the Year Nominee (Rabit)',
			'skills.awards.indieFund.title' => 'Indie Games Fund 2023',
			'skills.awards.indieFund.subtitle' => 'Winner (Farm vs Aliens)',
			'skills.awards.accelerator.title' => 'Indie Games Accelerator 2024',
			'skills.awards.accelerator.subtitle' => 'Graduate',
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
