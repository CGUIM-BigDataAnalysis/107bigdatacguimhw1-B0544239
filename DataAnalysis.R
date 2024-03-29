library(jsonlite)
library(dplyr)
library(readr)
X103edulevel <- read_csv("C:/Users/user/Desktop/RRR/103edulevel.csv")
X106edulevel <- read_csv("C:/Users/user/Desktop/RRR/106edulevel.csv")

for(a in 1:14){
  X103edulevel[[a]]<-gsub("-|...|、|_","",X103edulevel[[a]])
  }
for(a in 1:14){
  X106edulevel[[a]]<-gsub("-|...|、|_","",X106edulevel[[a]])
}
X103Edu<-select(X103edulevel,大職業別,starts_with("大學"),starts_with("研究所"))
X106Edu<-select(X106edulevel,大職業別,starts_with("大學"),starts_with("研究所"))

together<-inner_join(X103Edu,X106Edu,by="大職業別")
together$`大學-薪資.x`<-iconv(together$`大學-薪資.x`,"WINDOWS-1252","UTF-8")
together$`大學-薪資.x`<-as.numeric(together$`大學-薪資.x`)
together$`大學-薪資.y`<-iconv(together$`大學-薪資.y`,"WINDOWS-1252","UTF-8")
together$`大學-薪資.y`<-as.numeric(together$`大學-薪資.y`)

together$ratio<-together$`大學-薪資.y`/together$`大學-薪資.x`##透過比值>1為106年度較高的職業群
together<-arrange(together,desc(ratio))##排大小

Top<-together[together$ratio>1,]
head(Top,10)##前10   

per5<-together[together$ratio>1.05,]##超過5% 住宿及餐飲業,運輸及倉儲業,資訊及通訊傳播業

fre<-strsplit(per5$大職業別,"-")
Fre<-c()
for(n in 1:41){
  Fre<-c(Fre,fre[[n]][1])}
  table(Fre)  

##2
 
  X104edulevel <- read_csv("C:/Users/user/Desktop/RRR/104edulevel.csv")
  X105edulevel <- read_csv("C:/Users/user/Desktop/RRR/105edulevel.csv")

  for (n in 1:14){
    X103edulevel[[a]]<-gsub("—|…|、|_|","",X103edulevel[[a]])
  }
  for (n in 1:14){
    X104edulevel[[a]]<-gsub("—|…|、|_|—","",X104edulevel[[a]])
  }
  for (n in 1:14){
    X105edulevel[[a]]<-gsub("—|…|、|_|—","",X105edulevel[[a]])
  }
  for (n in 1:14){
    X106edulevel[[a]]<-gsub("—|…|、|_|—","",X106edulevel[[a]])
  }
  
  
  X103EL<-select(X103edulevel,年度,大職業別,starts_with("大學"),starts_with("研究所"))
  X104EL<-select(X104edulevel,年度,大職業別,starts_with("大學"),starts_with("研究所"))
  X105EL<-select(X105edulevel,年度,大職業別,starts_with("大學"),starts_with("研究所"))
  X106EL<-select(X106edulevel,年度,大職業別,starts_with("大學"),starts_with("研究所"))
  
  AA<-rbind(X103EL,X104EL,X105EL,X106EL)
  AA$`大學-女/男`<-iconv(AA$`大學-女/男`,"WINDOWS-1252","UTF-8")
  AA$`大學-女/男`<-as.numeric(AA$`大學-女/男`)
  AA<-arrange(AA,`大學-女/男`)
  
  Male<-subset(AA,`大學-女/男`<100)
  table(Male$大職業別) ##計算男生>女生 的數量
  Male ##差距由大到小
  head(Male,10)
  
  Female<-subset(AA,`大學-女/男`>100)
  table<-(Female$大職業別) ##計算男生<女生 的數量
  Female<-arrange(Female,desc(`大學-女/男`))
  Female## 差距由大到小
  head(Female,10)##前10名
  
  #3
  X106ELL<-select(X106edulevel,年度,大職業別,starts_with("大學-薪資"),starts_with("研究所及以上-薪資"))
  
  
  X106ELL$`大學-薪資`<-iconv(X106ELL$`大學-薪資`,"WINDOWS-1252","UTF-8")
  X106ELL$`研究所及以上-薪資`<-iconv(X106ELL$`研究所及以上-薪資`,"WINDOWS-1252","UTF-8")
  X106ELL$`大學-薪資`<-as.numeric(X106ELL$`大學-薪資`)
  X106ELL$`研究所及以上-薪資`<-as.numeric(X106ELL$`研究所及以上-薪資`)
  
  X106ELL$RRatio<-X106ELL$`研究所及以上-薪資`/X106ELL$`大學-薪資`
  X106ELL<-arrange(X106ELL,desc(RRatio))##由大排到小 #礦業及土石採取業-事務支援人員 最划算
  head(X106ELL,10)
  
  #4
  X106Love<-select(X106edulevel,年度,大職業別,starts_with("大學-薪資"),starts_with("研究所及以上-薪資"))
  X106Love$`大學-薪資`<-iconv(X106ELL$`大學-薪資`,"WINDOWS-1252","UTF-8")
  X106Love$`研究所及以上-薪資`<-iconv(X106ELL$`研究所及以上-薪資`,"WINDOWS-1252","UTF-8")
  X106Love$`大學-薪資`<-as.numeric(X106ELL$`大學-薪資`)
  X106Love$`研究所及以上-薪資`<-as.numeric(X106ELL$`研究所及以上-薪資`)
  
  X106Love$minus<-X106Love$`研究所及以上-薪資`-X106Love$`大學-薪資`
  X106Love<-arrange(X106Love,desc(minus))
  X106Love[grepl("批發及零售業",X106Love$大職業別),]
  X106Love[grepl("運輸及倉儲業",X106Love$大職業別),]

  ##以加薪的程度來說 大概都差2500~3500左右 看起來是當老闆比較好賺,跟我想像的完全不一樣,如果只差2500左右就不念了
  