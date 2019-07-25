#! /bin/bash
echo '开始'

#设置路径
outputpath=/mnt/d/svn.topdevil.com/he4js
scriptpath=/mnt/d/svn.topdevil.com/he4js/build-all-in-one-scripts-windows-sub-linux
respath=/mnt/d/svn.topdevil.com/he4js/game-project/HungryBird/bin/res
buindlefile=/mnt/d/svn.topdevil.com/he4js/game-project/HungryBird/bin/js/bundle.js

cd $respath

#执行转换命令
$scriptpath/b64.sh imgsdata.js
#$scriptpath/b64bin.sh otherbin.js

echo $scriptpath

go run $scriptpath/str2base64.go -start basicUIData=\" -end \" -s Basic.fui > basicUIData.txt
go run $scriptpath/str2base64.go -start otherbin=\" -end \" -s bird.sk > otherbin.js

#复制打包数据到根目录
mv imgsdata.js $outputpath/imgsdata.js
mv otherbin.js $outputpath/otherbin.js
mv basicUIData.txt $outputpath/basicUIData.txt

cd $outputpath
cp $scriptpath/index_editor_all_in_one.tpl index.html
cp $buindlefile bundle.js

#替换
go run $scriptpath/replace.go -f bundle.js -s1 "Game2D.allInOne=false" -s3 "Game2D.allInOne=true"
go run $scriptpath/replace.go -f index.html -s1 "(?s)(//startbasicUIData)(.*)//endbasicUIData" -s2 basicUIData.txt -start //startbasicUIData -end //endbasicUIData
go run $scriptpath/replace.go -f index.html -s1 "(?s)(//startimgsdata)(.*)//endimgsdata" -s2 imgsdata.js -start //startimgsdata -end //endimgsdata
go run $scriptpath/replace.go -f index.html -s1 "(?s)(//startotherbin)(.*)//endotherbin" -s2 otherbin.js -start //startotherbin -end //endotherbin
go run $scriptpath/replace.go -f index.html -s1 "(?s)//startbundlejs(.*)//endbundlejs" -s2 bundle.js -start //startbundlejs -end //endbundlejs

#清理
rm bundle.js
rm imgsdata.js
rm basicUIData.txt
rm otherbin.js

echo ""
echo "完成"