import Foundation

class KeyLevel {	 	
	
	init(){}    
    
	var text:String=""
    var content:String=""
    var level:Int = 0   
	var parentLevel:KeyLevel?     
	var mFavorChildren:[KeyLevel]? 				   
	var mChildren:[KeyLevel]? 			      
	func toStringLines() -> String {
		var sb:String = ""
		let preTabs = String(repeating:"  ", count:level)
		sb = preTabs + text + "\n"
		if let children = mChildren {
			for lvl in children {						
				sb += lvl.toStringLines()   
			}
		}	
		return sb; 
	}

} // end of class
	func buildKeyLevelHierarchy(_ dictionaryDefinition:String) -> KeyLevel  {
		// Create top key level
		var lvl = KeyLevel();
		lvl.level = 0
		lvl.text = "Dictionary" 		
		if dictionaryDefinition.characters.count < 1 {			
			return lvl;
		}
					
		// Create memory for selected key levels		
		var selKeyLevels = [KeyLevel]()
		selKeyLevels.append(lvl);

		// Scan dictionary definition string
		var depth:Int = 0
		var childText:String = ""
		var nu:KeyLevel = KeyLevel()	
        for cur in dictionaryDefinition.characters {
            if cur=="[" {
				if childText.characters.count>0 {
				    nu.text = childText
				}
				childText = ""
				depth+=1
				if depth>=0 && depth<selKeyLevels.count { 
				    selKeyLevels[depth] = nu
				} else if depth>=selKeyLevels.count{
				    selKeyLevels.append(nu)
				}
					
			} else if cur=="]" {
				if childText.characters.count>0 {
				    nu.text = childText
				}
				childText = ""
				depth-=1
			} else if cur == " " {
			    if childText.characters.count>0 {
				    nu.text = childText
				}
				childText = ""
			} else if childText.characters.count<1 {
				nu = KeyLevel()
				nu.level = depth
				childText.append(cur); //print("Create New Child \(cur)")
				if depth>=0 && depth<selKeyLevels.count {  
    				var parentLevel = selKeyLevels[depth]
    				if parentLevel.mChildren == nil {
    					parentLevel.mChildren = [nu]
    				} else {
    					parentLevel.mChildren?.append(nu)
    				}
				}
			} else {
			    if depth == 2 { //For PY's HZ
    			    if childText.characters.count>0 {
    				    nu.text = childText
    				}
    				childText = ""
    				
			        nu = KeyLevel()
    				nu.level = depth
    				childText.append(cur); 
    				if depth>=0 && depth<selKeyLevels.count {  
        				var parentLevel = selKeyLevels[depth]
        				if parentLevel.mChildren == nil {
        					parentLevel.mChildren = [nu]
        				} else {
        					parentLevel.mChildren?.append(nu)
        				}
    				}
			    } else {
			        childText.append(cur)
			    }
			}
		}
		if childText.characters.count>0 {
		    nu.text = childText
		}
				
		return lvl;

	} //end of func
	
//let str = "a[aa]b[bb[bbb]bx[bxa]by bz[bz1 bw bv]]c[cc]d ee fff[fffddd]"
//let str = "a[aa[aaa[aaaaa]ab[aba]]]b[b1[b11[b111]b12[b121]]]c[c1[c1a[c1a1]c2[c2a]c3[c3a]]]d[]"

let a_content:String="a[啊阿[爸 昌 拉伯数字 拉善盟 里 妈 姨 ]呵吖嗄腌锕錒厑]"
let ai_content:String="ai[爱[不释手 厂如家 戴 抚 国 好 护 科学 劳动 美 民 慕 情 人 惜 学习 憎 祖国 ]矮[个子 小 子 ]挨[打 饿 个 近 骂 门逐户 着 整 ]哎碍癌[症 ]艾[滋病 ]唉[声叹气 ]哀[悼 叫 求 伤 思 叹 怨 ]蔼隘埃皑呆[板 ]嗌嫒瑷暧[昧 ]捱砹嗳锿霭乂乃伌僾儗凒剀剴叆呃呝啀嘊噫噯堨塧壒奇娭娾嬡嵦愛懓懝敱敳昹曖欬欸毐溰溾濭烠焥璦皚皧瞹硋磑礙絠薆藹諰譪譺賹躷醷鎄鑀閡阂阨阸隑靄靉餲馤騃鯦鱫鴱]"
let an_content:String="an[按[比例 兵不动 部就班 此 计划 惯例 规定 劳分配 劳取酬 理 量 捺不住 年 钮 期 人均计算 日 上级规定 时 说 语 原定计划 原计划 原则办事 月 照 着 制度办事 ]安[安静静 安稳稳 达 定 顿 度晚年 放 分 抚 徽 家 静 居 康 乐 理会 谧 民 排 庆 全 然 上 身 慰 危 稳 息 详 祥 下心来 歇 心 逸 营扎寨 于现状 葬 置 装 ]暗[暗 藏 处 淡 地里 杀 示 下决心 中 ]岸[边 上 ]俺案[犯 件 例 情 子 ]鞍[钢 山 ]氨胺厂广庵揞犴铵桉谙鹌埯黯[然失色 ]侒儑匼厈咹唵啽垵垾堓婩媕屽峖干晻洝玵痷盒盦盫碪罯腤荌菴萻葊蓭裺誝諳豻貋遃鉗銨錌钳闇陰隂隌雸鞌韽頇頞顸馣鮟鴳鵪鶕]"
let ang_content:String="ang[昂[贵 然 首 扬 ]肮[脏 ]盎[然 ]仰卬岇昻枊醃醠骯]"
let ao_content:String="ao[袄凹[凸不平 ]傲[骨 慢 气 然 ]奥[秘 林匹克[精神 大会 ]妙[无穷 ]委会[主席 ]运会 ]熬懊[悔 恼 ]敖翱[翔 ]澳[大利亚 门 洲 ]嚣拗媪廒骜嗷坳遨[游[宇宙 太空 ]]聱螯獒鏊鳌鏖[战 ]岙厫嗸噢嚻囂垇墺墽奡奧媼嫯岰嶅嶴慠扷抝摮擙柪梎棍泑浇滶澆澚熝爊獓璈眑磝磽礉翶翺芺蔜蝹襖謷謸軪郩鏕镺隞驁鰲鴁鴢鷔鼇]"

let sb:String="a[" + a_content + ai_content + an_content + ang_content + ao_content + "]"

var lvl = buildKeyLevelHierarchy(sb)
print(lvl.toStringLines())

	
	