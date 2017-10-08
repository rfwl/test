import Foundation

class DictionaryBuilder {
	//================================================================================
	// Top Key Level and Most-Used-KeyLevel
    let mTopKeyLevel:KeyLevel
    let mMostUsedKeyLevel:KeyLevel
    
	init(){
	
    	mTopKeyLevel=KeyLevel()
		mTopKeyLevel.parentLevel=nil
		mTopKeyLevel.level=0
		mTopKeyLevel.text=""
		
		mTopKeyLevel.content=buildDictionaryContent()
		mTopKeyLevel.fillChildrenArrayFromContentString() 
		// Here the whole dictionary has been setup from top to bottom-most.
		buildFavorArrayForPIs()
		
		mMostUsedKeyLevel=KeyLevel()
		mMostUsedKeyLevel.parentLevel=nil
		mMostUsedKeyLevel.level=0
		mMostUsedKeyLevel.text=""
		mMostUsedKeyLevel.mChildren=buildKeyLevelArrayFromOnePYOneHZString(most_used_py_hz_string)
	}
    //================================================================================
	// Build Dictionary Content
	
    //================================================================================
	// Build Favor Children for PIs
    func buildFavorArrayForPIs(){
    	if let children=mTopKeyLevel.mChildren { 
			for pi in children {
				let favorString:String=getPIFavorString(pi)
				let favors:[KeyLevel]? = buildKeyLevelArrayFromOnePYOneHZString(favorString)
				pi.mChildren = favors
			}
		}   	
	}
    
    func buildKeyLevelArrayFromOnePYOneHZString(pyhz:String) -> [KeyLevel]? {    	
  
    	let ary =  s.characters.split{$0 == ","}.map(String.init) 
    	if ary.count<2 {return nil}		
    	var lvls:[KeyLevel]=[KeyLeve]() 
    	for i in stride(from: 0, to: ary.count-2, by: 2) {
			let py=ary[i]
			let hz=ary[i+1]							
			let lvl:KeyLevel? = getHZUnderPY(hz_text:hz,py_text:py)
			if let hzLvl=lvl {
				lvls.append(hzLvl)
			}
		}
    	if lvls.count > 0 {
    		return lvls
    	}
		return lvls
	}
    
    //================================================================================
	// Helper Method for Access KeyLevel
	func getPI(pi_text:String) -> KeyLevel? {
		if let children=mTopKeyLevel.mChildren { 
			for pi in children {
				if pi.text == pi_text {
					return pi
				}
			}
		}
		return nil
	}
	
	funct getPY(py_text:String) -> KeyLevel? {
		if let children1=mTopKeyLevel.mChildren { 
			for pi in children {
				if let children2=pi.mChildren { 
					for py in children2 {
						if py.text == py_text {
							return py
						}
					}
				}
			}
		}	
		return nil
	}
		
	func getHZUnderPY(hz_text:String, py_text:String) -> KeyLevel? {
		var py:KeyLevel? = getPY(py_text);
		if let pyLevel=py { 
			for hz in pyLevel.mChildren {
				if hz.text == hz_text {
					return hz
				}
			}
		}
		return nil
	}
	
	//================================================================================
	// Constant area	
	func buildDictionaryContent() -> String	{
		var sb:String=""		
		sb.append("a[").append(a_content).append(ai_content).append(an_content).append(ang_content).append(ao_content).append("]")			
        return sb
    } 
		
    func getPIFavorString(pi:KeyLevel) -> String {
		if pi.text == "a" { return PI_a_favors}
		return ""
    }

//================================================================================
// Most used hanzis
let most_used_py_hz_string:String="de,的,yi,一,shi,是,le,了,wo,我,bu,不,ren,人,zai,在,ta,他,you,有,zhe,这,ge,个,shang,上,men,们,lai,来,dao,到,shi,时,da,大,di,地,wei,为,zi,子,zhong,中,ni,你,shuo,说,sheng,生,guo,国,nian,年,zhuo,着,jiu,就,na,那,he,和,yao,要,ta,她,chu,出,ye,也,de,得,li,里,hou,后,zi,自,yi,以,hui,会,jia,家,ke,可,xia,下,er,而,guo,过,tian,天,qu,去,neng,能,dui,对,xiao,小,duo,多,ran,然,yu,于,xin,心,xue,学,mo,么,zhi,之,dou,都,hao,好,kan,看,qi,起,fa,发,dang,当,mei,没,cheng,成,zhi,只,ru,如,shi,事,ba,把,huan,还,yong,用,di,第,yang,样,dao,道,xiang,想,zuo,作,zhong,种,kai,开,mei,美,zong,总,cong,从,wu,无,qing,情,ji,己,mian,面,zui,最,nv,女,dan,但,xian,现,qian,前,xie,些,suo,所,tong,同,ri,日,shou,手,you,又,xing,行,yi,意,dong,动,fang,方,qi,期,ta,它,tou,头,jing,经,chang,长,er,儿,hui,回,wei,位,fen,分,ai,爱,lao,老,yin,因,hen,很,gei,给,ming,名,fa,法,jian,间,si,斯,zhi,知,shi,世,shen,什,liang,两,ci,次,shi,使,shen,身,zhe,者,bei,被,gao,高,yi,已,qin,亲,qi,其,jin,进,ci,此,hua,话,chang,常,yu,与,huo,活,zheng,正,gan,感,"
//================================================================================
// 	PI favors	
let PI_a_favors:String="a,阿,a,啊,ai,爱,an,安,an,干,an,案,an,按,an,暗,ao,奥,"	
//================================================================================
// Pinyin Defintions
let a_content:String="a[啊阿[爸 昌 拉伯数字 拉善盟 里 妈 姨 ]呵吖嗄腌锕錒厑]"
let ai_content:String="ai[爱[不释手 厂如家 戴 抚 国 好 护 科学 劳动 美 民 慕 情 人 惜 学习 憎 祖国 ]矮[个子 小 子 ]挨[打 饿 个 近 骂 门逐户 着 整 ]哎碍癌[症 ]艾[滋病 ]唉[声叹气 ]哀[悼 叫 求 伤 思 叹 怨 ]蔼隘埃皑呆[板 ]嗌嫒瑷暧[昧 ]捱砹嗳锿霭乂乃伌僾儗凒剀剴叆呃呝啀嘊噫噯堨塧壒奇娭娾嬡嵦愛懓懝敱敳昹曖欬欸毐溰溾濭烠焥璦皚皧瞹硋磑礙絠薆藹諰譪譺賹躷醷鎄鑀閡阂阨阸隑靄靉餲馤騃鯦鱫鴱]"
let an_content:String="an[按[比例 兵不动 部就班 此 计划 惯例 规定 劳分配 劳取酬 理 量 捺不住 年 钮 期 人均计算 日 上级规定 时 说 语 原定计划 原计划 原则办事 月 照 着 制度办事 ]安[安静静 安稳稳 达 定 顿 度晚年 放 分 抚 徽 家 静 居 康 乐 理会 谧 民 排 庆 全 然 上 身 慰 危 稳 息 详 祥 下心来 歇 心 逸 营扎寨 于现状 葬 置 装 ]暗[暗 藏 处 淡 地里 杀 示 下决心 中 ]岸[边 上 ]俺案[犯 件 例 情 子 ]鞍[钢 山 ]氨胺厂广庵揞犴铵桉谙鹌埯黯[然失色 ]侒儑匼厈咹唵啽垵垾堓婩媕屽峖干晻洝玵痷盒盦盫碪罯腤荌菴萻葊蓭裺誝諳豻貋遃鉗銨錌钳闇陰隂隌雸鞌韽頇頞顸馣鮟鴳鵪鶕]"
let ang_content:String="ang[昂[贵 然 首 扬 ]肮[脏 ]盎[然 ]仰卬岇昻枊醃醠骯]"
let ao_content:String="ao[袄凹[凸不平 ]傲[骨 慢 气 然 ]奥[秘 林匹克[精神 大会 ]妙[无穷 ]委会[主席 ]运会 ]熬懊[悔 恼 ]敖翱[翔 ]澳[大利亚 门 洲 ]嚣拗媪廒骜嗷坳遨[游[宇宙 太空 ]]聱螯獒鏊鳌鏖[战 ]岙厫嗸噢嚻囂垇墺墽奡奧媼嫯岰嶅嶴慠扷抝摮擙柪梎棍泑浇滶澆澚熝爊獓璈眑磝磽礉翶翺芺蔜蝹襖謷謸軪郩鏕镺隞驁鰲鴁鴢鷔鼇]"
//================================================================================

	
} //end of class

let db = Dictionary()

