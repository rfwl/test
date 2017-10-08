
class ZDHanziDictionary {
    
    let hanziDictionaryDef:ZDHanziDictionaryDefinition = ZDHanziDictionaryDefinition()
    //===================================================
   	// Top and specialKeyLevels
    let mTopKeyLevel:KeyLevel
    
  	let mNumberKeyLevel:KeyLevel
  	let mAlphabetKeyLevel:KeyLevel
  	let mSymbolKeyLevel:KeyLevel
  	
  	let mMostUsedKeyLevel:KeyLevel
  	let mRecentKeyLevel:KeyLevel
  	    
    init(){
		//------------------------------------- Init KeyLevels
        mTopKeyLevel = KeyLevel();
        mTopKeyLevel.level = 0
        mTopKeyLevel.parentLevel = nil
        mTopKeyLevel.text = "Dictionary"
    
		mNumberKeyLevel = KeyLevel() 
		mNumberKeyLevel.parentLevel=nil
		mNumberKeyLevel.level=0
		mNumberKeyLevel.text="Number"
		        
		mAlphabetKeyLevel = KeyLevel()
		mAlphabetKeyLevel.parentLevel=nil
		mAlphabetKeyLevel.level=0
		mAlphabetKeyLevel.text="Alphabet"
		
		mSymbolKeyLevel = KeyLevel() 
		mSymbolKeyLevel.parentLevel=nil
		mSymbolKeyLevel.level=0
		mSymbolKeyLevel.text="Symbol"
			  	
		mMostUsedKeyLevel = KeyLevel() 
		mMostUsedKeyLevel.parentLevel=nil
		mMostUsedKeyLevel.level=0
		mMostUsedKeyLevel.text="Most Used Hanzis"
		
		mRecentKeyLevel = KeyLevel() 		
		mRecentKeyLevel.parentLevel=nil
		mRecentKeyLevel.level=0
		mRecentKeyLevel.text="Recent Used Hanzis"
        
        //------------------------------------- Build top keyLevel
        var dicDefString = hanziDictionaryDef.buildDictionaryDefinition()
        self.buildDictionary(dicDefString)
        self.buildFavorArrayForPIs()
        //------------------------------------- Build keyLevels
        mNumberKeyLevel.mChildren = buildKeyLevelArrayFromCommaSeparatedString(numberKeyLevelDefinition)
        mAlphabetKeyLevel.mChildren = buildKeyLevelArrayFromCommaSeparatedString(alphabetKeyLevelDefinition)
        mSymbolKeyLevel.mChildren = buildKeyLevelArrayFromCommaSeparatedString(symbolKeyLevelDefinition)
        
        mMostUsedKeyLevel.mChildren=buildKeyLevelArrayFromOnePYOneHZString(hanziDictionaryDef.most_used_py_hz_string)
        
        
    } // end of init
	
    let numberKeyLevelDefinition:String = "0,1,2,3,4,5,6,7,8,9,+,-,*,/,=,comma, ,?"
    let alphabetKeyLevelDefinition:String = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,+,-,*,/,=,comma"
    let symbolKeyLevelDefinition:String = "!,@,#,$,%,^,&,*,(,),_,+,{,},[,],<,>,/,comma, ,"
    
	//===================================================
    // Build Dictionary
    func buildDictionary(_ dictionaryDefinition:String) {
        if dictionaryDefinition.characters.count < 1 {
            return
        }
        
        // Create memory for selected key levels
        var selKeyLevels = [KeyLevel]()
        selKeyLevels.append(mTopKeyLevel);
        
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
    } //end of func
    //===================================================
    // Build Favor Children for PIs
    func buildFavorArrayForPIs(){
        if let children=mTopKeyLevel.mChildren {
            for pi in children {
                let favorString:String=hanziDictionaryDef.getPIFavorString(pi:pi)
                let favors:[KeyLevel]? = buildKeyLevelArrayFromOnePYOneHZString(favorString)
                pi.mFavorChildren = favors
            }
        }
    }
    
    func buildKeyLevelArrayFromOnePYOneHZString(_ pyhz:String) -> [KeyLevel]? {
        
        let ary =  pyhz.characters.split{$0 == ","}.map(String.init)
        if ary.count<2 {return nil}
        var lvls:[KeyLevel]=[KeyLevel]()
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
        return nil
    }
    
    func buildKeyLevelArrayFromCommaSeparatedString(_ css:String) -> [KeyLevel]? {
        let ary =  css.characters.split{$0 == ","}.map(String.init)
        if ary.count<1 {return nil}
        var lvls:[KeyLevel]=[KeyLevel]()
        for i in 0..<ary.count {
            var txt=ary[i]
            
            if txt == "comma" {txt = ","}
            //if txt == "" {continue}
            let lvl:KeyLevel = KeyLevel()
            lvl.text = txt
            lvls.append(lvl)
        }
        if lvls.count > 0 {
            return lvls
        }
        return nil
    }
    //===================================================
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
    func getPY(py_text:String) -> KeyLevel? {
        if let children=mTopKeyLevel.mChildren { 
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
        let py:KeyLevel? = getPY(py_text:py_text);
        if let pyLevel=py { 
            if let children = pyLevel.mChildren {
                for hz in children {
                    if hz.text == hz_text {
                        return hz
                    }
                }
            }	    
        }
        return nil
    }
    //===================================================
    
} //end of class
/*
 var db = ZDHanziDictionary()
 var dic = db.mTopKeyLevel
 //print(dic.toStringLines())
 print("=================================")
 for pi in db.mTopKeyLevel.mChildren! {
 print("PI=\(pi.text)")
 for fav in pi.mFavorChildren! {
 //print(fav.toStringLines()) 
 }
 }
 print("=================================")
 var muhz = db.mMostUsedKeyLevel
 print(muhz.toStringLines())
 */
