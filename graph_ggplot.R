load("~/Desktop/wenyingliu/data.RData")
#just test something
##02012018
######adjustcount-term
p<-ggplot(food,aes(term,adjcount,group=city))
p+geom_line(aes(color=city))

ggplot(food, aes(term, adjcount,fill=term)) + geom_bar(stat="identity") +facet_grid(. ~ city)
  #for spacific city
ggplot(LA, aes_string(x="term", y="adjcount")) + geom_bar(stat="identity")

#sentiment-term
p<-ggplot(food,aes(city,sentiment,group=term))+geom_line(aes(color=term))

ggplot(food, aes(term, sentiment,fill=term)) + geom_bar(stat="identity") +facet_grid(. ~ city)
  #for spacific city
ggplot(LA, aes_string(x="term", y="sentiment")) + geom_boxplot()

#spacific city---sentiment vs. adjcount
par(mfrow=c(2,1))
data<-matrix(food[food$city=="Los Angeles",]$adjcount,nrow=1)
colnames(data)<-food[food$city=="Los Angeles",]$term
barplot(data)
data1<-matrix(food[food$city=="Los Angeles",]$sentiment,nrow=1)
colnames(data1)<-food[food$city=="Los Angeles",]$term
barplot(data1)

#does food price affect the food fad:
p<-ggplot(food,aes(term,avgprice,group=city))
p+geom_line(aes(color=city))

ggplot(food,aes(city,avgprice,group=term))+geom_line(aes(color=term))
ggplot(food, aes(term, avgprice,fill=term)) + geom_bar(stat="identity") +facet_grid(. ~ city)

#for spacific city
ggplot(LA, aes_string(x="term", y="avgprice")) + geom_bar(stat="identity")

#price vs.sentiment
m=avgprice
par(mfrow=c(2,1))
data<-matrix(LA$m,nrow=1)
colnames(data)<-LA$term
barplot(data)
data1<-matrix(LA$sentiment,nrow=1)
colnames(data1)<-LA$term
barplot(data1)

#income effect
ggplot(census,aes(city,Med._Income))+geom_boxplot()
ggplot(census,aes(city,Med._Income))+geom_bar(stat="identity")
