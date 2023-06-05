# ChineseWords.coffee

export hZhWords = {
	'一':
		pinyin: 'yī'
		en: 'one'
	'杀':
		pinyin: 'shā'
		en: 'kill'
	'死':
		pinyin: 'sǐ'
		en: 'die, pass away'
		comment: 'nothing'
	'受伤':
		pinyin: 'shòu shāng'
		en: 'injure, hurt'
	'持有':
		pinyin: 'chí yǒu'
		en: 'hold'
	'发生':
		pinyin: 'fā shēng'
		en: 'happen'
	'建造':
		pinyin: 'jiàn zào'
		en: 'build'
	'斗争':
		pinyin: 'dòu zhēng'
		en: 'fight'
	'需要':
		pinyin: 'xū yào'
		en: 'need'
	'有':
		pinyin: 'yǒu'
		en: 'have'
	'跳':
		pinyin: 'tiào'
		en: 'jump, hop'
	}

for own key,value of hZhWords
	hZhWords[key].zh = key
