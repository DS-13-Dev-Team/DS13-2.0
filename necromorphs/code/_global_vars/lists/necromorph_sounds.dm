/// Update this list if you are adding new sounds
GLOBAL_LIST_INIT(necromorph_sounds, list(
	"Slasher" = slasher_sounds,
	"Exploder" = exploder_sounds,
	"Infector" = infector_sounds,
	"Leaper" = leaper_sounds,
	"Spitter" = spitter_sounds,
	"Lurker" = lurker_sounds,
	"Enhanced Slasher" = enhanced_slasher_sounds,
	"Puker" = puker_sounds,
	"Twitcher" = twitcher_sounds,
	"Brute" = brute_sounds,
	"Divider" = divider_sounds,
	"Hunter" = hunter_sounds,
	"Tripod" = tripod_sounds,
	"Ubermorph" = ubermorph_sounds,
))

GLOBAL_LIST_INIT(slasher_sounds, list(
	SOUND_ATTACK = list(
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_7.ogg'
	),
	SOUND_DEATH = list(
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_death_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_death_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_death_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_death_4.ogg',
	),
	SOUND_PAIN = list(
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_pain_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_pain_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_pain_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_pain_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_pain_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_pain_6.ogg',
	),
	SOUND_SHOUT = list(
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_4.ogg',
	),
	SOUND_SHOUT_LONG = list(
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_long_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_long_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_long_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_long_4.ogg',
	),
	SOUND_SPEECH = list(
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_speech_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher/slasher_speech_2.ogg',
	)
))

GLOBAL_LIST_INIT(leaper_sounds, list(
	SOUND_FOOTSTEP = list(
		'necromorphs/sound/effects/footstep/leaper_footstep_1.ogg',
		'necromorphs/sound/effects/footstep/leaper_footstep_2.ogg',
		'necromorphs/sound/effects/footstep/leaper_footstep_3.ogg',
		'necromorphs/sound/effects/footstep/leaper_footstep_4.ogg',
		'necromorphs/sound/effects/footstep/leaper_footstep_5.ogg',
	),
	SOUND_CLIMB = list(
		'necromorphs/sound/effects/footstep/wall_climb_1.ogg',
		'necromorphs/sound/effects/footstep/wall_climb_2.ogg',
		'necromorphs/sound/effects/footstep/wall_climb_3.ogg',
		'necromorphs/sound/effects/footstep/wall_climb_4.ogg',
		'necromorphs/sound/effects/footstep/wall_climb_5.ogg',
		'necromorphs/sound/effects/footstep/wall_climb_6.ogg',
	),
	SOUND_PAIN = list(
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_pain_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_pain_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_pain_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_pain_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_pain_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_pain_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_pain_7.ogg',
	),
	SOUND_DEATH = list(
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_death_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_death_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_death_3.ogg',
	),
	SOUND_ATTACK = list(
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_attack_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_attack_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_attack_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_attack_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_attack_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_attack_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_attack_7.ogg',
	),
	SOUND_SHOUT = list(
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_shout_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_shout_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_shout_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_shout_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_shout_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_shout_6.ogg',
	),
	SOUND_SHOUT_LONG = list(
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_shout_long_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_shout_long_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_shout_long_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_shout_long_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_shout_long_5.ogg',
	),
	SOUND_SPEECH = list(
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_speech_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_speech_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_speech_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/leaper/leaper_speech_4.ogg',
	)
))

GLOBAL_LIST_INIT(puker_sounds, list(
	SOUND_ATTACK = list(
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_attack_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_attack_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_attack_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_attack_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_attack_5.ogg',
	),
	SOUND_DEATH = list(
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_death_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_death_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_death_3.ogg',
	),
	SOUND_PAIN = list(
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_pain_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_pain_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_pain_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_pain_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_pain_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_pain_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_pain_7.ogg',
	),
	SOUND_SHOUT = list(
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_6.ogg',
	),
	SOUND_SHOUT_LONG = list(
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_long_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_long_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_long_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_shout_long_4.ogg',
	),
	SOUND_SPEECH = list(
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_speech_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_speech_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/puker/puker_speech_3.ogg',
	)
))

GLOBAL_LIST_INIT(spitter_sounds, list(
	SOUND_ATTACK = list(
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_attack_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_attack_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_attack_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_attack_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_attack_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_attack_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_attack_7.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_attack_8.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_attack_9.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_attack_extreme.ogg',
	),
	SOUND_DEATH = list(
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_death_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_death_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_death_3.ogg',
	),
	SOUND_PAIN = list(
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_pain_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_pain_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_pain_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_pain_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_pain_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_pain_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_pain_7.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_pain_8.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_pain_extreme.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_pain_extreme_2.ogg',
	),
	SOUND_SHOUT = list(
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_shout_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_shout_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_shout_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_shout_4.ogg',
	),
	SOUND_SHOUT_LONG = list(
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_shout_long_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_shout_long_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_shout_long_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_shout_long_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_shout_long_5.ogg',
	),
	SOUND_SPEECH = list(
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_speech_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_speech_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_speech_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_speech_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/spitter/spitter_speech_5.ogg',
	)
))

GLOBAL_LIST_INIT(brute_sounds, list(
	SOUND_PAIN = list(
		'necromorphs/sound/effects/creatures/necromorph/brute/brute_pain_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/brute/brute_pain_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/brute/brute_pain_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/brute/brute_pain_extreme.ogg',
	),
	SOUND_DEATH = list(
		'necromorphs/sound/effects/creatures/necromorph/brute/brute_death.ogg',
	),
	SOUND_ATTACK = list(
		'necromorphs/sound/effects/creatures/necromorph/brute/brute_attack_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/brute/brute_attack_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/brute/brute_attack_3.ogg',
	),
	SOUND_SHOUT = list(
		'necromorphs/sound/effects/creatures/necromorph/brute/brute_shout_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/brute/brute_shout_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/brute/brute_shout_3.ogg',
	),
	SOUND_SHOUT_LONG = list(
		'necromorphs/sound/effects/creatures/necromorph/brute/brute_shout_long.ogg',
	),
	SOUND_FOOTSTEP = list(
		'necromorphs/sound/effects/footstep/brute_step_1.ogg',
		'necromorphs/sound/effects/footstep/brute_step_2.ogg',
		'necromorphs/sound/effects/footstep/brute_step_3.ogg',
		'necromorphs/sound/effects/footstep/brute_step_4.ogg',
		'necromorphs/sound/effects/footstep/brute_step_5.ogg',
		'necromorphs/sound/effects/footstep/brute_step_6.ogg'
	)
))

GLOBAL_LIST_INIT(exploder_sounds, list(
	SOUND_ATTACK = list(
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_attack_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_attack_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_attack_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_attack_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_attack_5.ogg',
	),
	SOUND_DEATH = list(
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_death_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_death_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_death_3.ogg',
	),
	SOUND_PAIN = list(
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_pain_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_pain_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_pain_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_pain_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_pain_5.ogg',
	),
	SOUND_SHOUT = list(
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_7.ogg',
	),
	SOUND_SHOUT_LONG = list(
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_long_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_long_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_long_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_long_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_long_5.ogg',
	),
	SOUND_SPEECH = list(
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_speech_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_speech_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_speech_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_speech_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_speech_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_speech_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/exploder/exploder_speech_7.ogg',
	)
))

GLOBAL_LIST_INIT(hunter_sounds, list(
	SOUND_ATTACK = list(
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_7.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_8.ogg',
	),
	SOUND_PAIN = list(
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_7.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_8.ogg',
	),
	SOUND_SHOUT = list(
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_7.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_8.ogg',
	),
	SOUND_SHOUT_LONG = list(
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_long_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_long_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_long_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_long_4.ogg',
	),
	SOUND_SPEECH = list(
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_7.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_8.ogg',
	),
	SOUND_REGEN = list(
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_regen_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_regen_2.ogg',
	)
))

GLOBAL_LIST_INIT(twitcher_sounds, list(
	SOUND_ATTACK = list(
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_attack_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_attack_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_attack_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_attack_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_attack_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_attack_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_attack_7.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_attack_8.ogg',
	),
	SOUND_DEATH = list(
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_death_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_death_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_death_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_death_4.ogg',
	),
	SOUND_PAIN = list(
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_pain_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_pain_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_pain_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_pain_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_pain_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_pain_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_pain_7.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_pain_8.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_pain_9.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_pain_extreme.ogg',
	),
	SOUND_SHOUT = list(
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_shout_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_shout_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_shout_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_shout_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_shout_5.ogg',
	),
	SOUND_SHOUT_LONG = list(
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_shout_long_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_shout_long_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_shout_long_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_shout_long_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_shout_long_5.ogg',
	),
	SOUND_SPEECH = list(
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_speech_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_speech_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_speech_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_speech_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/twitcher/twitcher_speech_5.ogg',
	)
))

GLOBAL_LIST_INIT(ubermorph_sounds, list(
	SOUND_ATTACK = list(
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_7.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_8.ogg',
	),
	SOUND_PAIN = list(
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_7.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_8.ogg',
	),
	SOUND_SHOUT = list(
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_7.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_8.ogg',
	),
	SOUND_SHOUT_LONG = list(
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_long_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_long_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_long_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_long_4.ogg',
	),
	SOUND_SPEECH = list(
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_7.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_8.ogg',
	),
	SOUND_REGEN = list(
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_regen_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/ubermorph/ubermorph_regen_2.ogg',
	)
))

GLOBAL_LIST_INIT(divider_sounds, list(
	SOUND_ATTACK = list(
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_attack_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_attack_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_attack_3.ogg',
	),
	SOUND_DEATH = list(
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_death.ogg',
	),
	SOUND_PAIN = list(
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_pain_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_pain_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_pain_3.ogg',
	),
	SOUND_SHOUT = list(
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_shout_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_shout_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_shout_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_shout_4.ogg',
	),
	SOUND_SHOUT_LONG = list(
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_shout_long_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_shout_long_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_shout_long_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_shout_long_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_shout_long_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_shout_long_6.ogg',
	),
	SOUND_SPEECH = list(
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_shout_long_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_shout_long_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_shout_long_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_shout_long_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_shout_long_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/divider/divider_shout_long_6.ogg',
	)
))

GLOBAL_LIST_INIT(infector_sounds, list(
	SOUND_FOOTSTEP = list(
		'necromorphs/sound/effects/footstep/infector_footstep_1.ogg',
		'necromorphs/sound/effects/footstep/infector_footstep_2.ogg',
		'necromorphs/sound/effects/footstep/infector_footstep_3.ogg',
		'necromorphs/sound/effects/footstep/infector_footstep_4.ogg',
	),
	SOUND_ATTACK = list(
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_attack_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_attack_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_attack_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_attack_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_attack_5.ogg',
	),
	SOUND_DEATH = list(
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_death_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_death_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_death_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_death_4.ogg',
	),
	SOUND_PAIN = list(
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_pain_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_pain_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_pain_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_pain_4.ogg',
	),
	SOUND_SHOUT = list(
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_shout_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_shout_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_shout_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_shout_4.ogg',
	),
	SOUND_SHOUT_LONG = list(
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_shout_long_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_shout_long_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/infector/infector_shout_long_3.ogg',
	)
))

GLOBAL_LIST_INIT(tripod_sounds, list(
	SOUND_FOOTSTEP = list(
		'necromorphs/sound/effects/footstep/tripod_footstep_1.ogg',
		'necromorphs/sound/effects/footstep/tripod_footstep_2.ogg',
		'necromorphs/sound/effects/footstep/tripod_footstep_3.ogg',
		'necromorphs/sound/effects/footstep/tripod_footstep_4.ogg',
		'necromorphs/sound/effects/footstep/tripod_footstep_5.ogg',
		'necromorphs/sound/effects/footstep/tripod_footstep_6.ogg',
	),
	SOUND_ATTACK = list(
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_attack_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_attack_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_attack_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_attack_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_attack_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_attack_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_attack_7.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_attack_8.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_attack_9.ogg',
	),
	SOUND_DEATH = list(
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_death_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_death_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_death_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_death_4.ogg',
	),
	SOUND_PAIN = list(
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_pain_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_pain_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_pain_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_pain_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_pain_5.ogg',
	),
	SOUND_SHOUT = list(
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_6.ogg',
	),
	SOUND_SHOUT_LONG = list(
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_long_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_long_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_long_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_long_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_long_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/tripod/tripod_shout_long_6.ogg',
	)
))

GLOBAL_LIST_INIT(lurker_sounds, list(
	SOUND_ATTACK = list(
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_attack_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_attack_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_attack_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_attack_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_attack_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_attack_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_attack_7.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_attack_8.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_attack_9.ogg',
	),
	SOUND_CLIMB = list(
		'necromorphs/sound/effects/footstep/wall_climb_1.ogg',
		'necromorphs/sound/effects/footstep/wall_climb_2.ogg',
		'necromorphs/sound/effects/footstep/wall_climb_3.ogg',
		'necromorphs/sound/effects/footstep/wall_climb_4.ogg',
		'necromorphs/sound/effects/footstep/wall_climb_5.ogg',
		'necromorphs/sound/effects/footstep/wall_climb_6.ogg',
	),
	SOUND_DEATH = list(
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_death_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_death_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_death_3.ogg',
	),
	SOUND_FOOTSTEP = list(
		'necromorphs/sound/effects/footstep/lurker_footstep_1.ogg',
		'necromorphs/sound/effects/footstep/lurker_footstep_2.ogg',
		'necromorphs/sound/effects/footstep/lurker_footstep_3.ogg',
		'necromorphs/sound/effects/footstep/lurker_footstep_4.ogg',
		'necromorphs/sound/effects/footstep/lurker_footstep_5.ogg',
		'necromorphs/sound/effects/footstep/lurker_footstep_6.ogg',
		'necromorphs/sound/effects/footstep/lurker_footstep_7.ogg',
	),
	SOUND_PAIN = list(
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_pain_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_pain_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_pain_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_pain_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_pain_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_pain_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_pain_7.ogg',
	),
	SOUND_SHOUT = list(
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_shout_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_shout_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_shout_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_shout_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_shout_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_shout_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_shout_7.ogg',
	),
	SOUND_SHOUT_LONG = list(
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_shout_long_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_shout_long_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_shout_long_3.ogg',
	),
	SOUND_SPEECH = list(
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_speech_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_speech_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_speech_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/lurker/lurker_speech_4.ogg',
	)
))

GLOBAL_LIST_INIT(enhanced_slasher_sounds, list(
	SOUND_ATTACK = list(
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_6.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_7.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_8.ogg',
	),
	SOUND_DEATH = list(
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_death_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_death_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_death_3.ogg',
	),
	SOUND_PAIN = list(
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_extreme.ogg',
	),
	SOUND_SHOUT = list(
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_6.ogg',
	),
	SOUND_SHOUT_LONG = list(
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_4.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_5.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_6.ogg',
	),
	SOUND_SPEECH = list(
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_speech_1.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_speech_2.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_speech_3.ogg',
		'necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_speech_4.ogg',
	)
))
