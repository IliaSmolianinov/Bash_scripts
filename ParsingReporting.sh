#!/bin/bash


read -p "Введите url: " URL
wget -nv $URL   

FILE=$(echo $URL | rev | cut -f1 -d'/' | rev)

DATE=$(date +%d/%m/%y | sed s'/\//_/g')

if [[ $# == 1 ]]
then
	SERVER=$1
else
	SERVER="DEFAULT"
fi


cat $FILE | grep "CrashLoopBackOff\|Error" | cut -f1 -d' ' | sed 's/-.\{9,10\}-.\{5\}$//' >> "${SERVER}_${DATE}_failed.out"
cat $FILE | grep Running | cut -f1 -d' ' | sed 's/-.\{9,10\}-.\{5\}$//' >> "${SERVER}_${DATE}_running.out"

echo "Количество работающих сервисов: $(wc -l "${SERVER}_${DATE}_running.out" | cut -f1 -d' ')" >> "${SERVER}_${DATE}_report.out"
echo "Количество сервисов с ошибками: $(wc -l "${SERVER}_${DATE}_failed.out" | cut -f1 -d' ')" >> "${SERVER}_${DATE}_report.out"
echo "Имя системного пользователя: $USER" >> "${SERVER}_${DATE}_report.out"
echo "Дата: $(date +%d/%m/%y)" >> "${SERVER}_${DATE}_report.out"

chmod 444 "${SERVER}_${DATE}_report.out"


ARCH="./archive/${SERVER}_${DATE}.tar.gz"
if [[ ! -f $ARCH ]]
then
	tar -zcvf $ARCH "${SERVER}_${DATE}"*.out > /dev/null
	rm -f "${SERVER}_${DATE}"* $FILE
	tar -tvzf $ARCH > /dev/null

	if [[ $? == 0 ]]
	then
		echo "Архив ${SERVER}_${DATE} создан и проверен!"
		exit 0
	else
		echo "Ахив ${SERVER}_${DATE} поврежден!"
		exit 1
	fi
else
	echo "Архив $ARCH уже существует"
	rm -f "${SERVER}_${DATE}"* $FILE
	exit 1
fi

# Приветствую, уважаемый потенциальный работодатель!
# Прежде всего хочу сказать, что получил большое удовольствие от прохождения тестового задания, и поблагодарить за шанс предоставленный мне. Выполняя его я получаю столь необходимые практические навыки и пополняю портфолио. 
# Если по какой-то причине вы не сможете предложить мне эту вакансию, я готов рассмотреть любые другие варианты сотрудничества, вплоть до безвозмездного(ну как безвозмездного, вы мне практику и обратную связь (по возможности), я вам какие-никакие куски рабочего кода или конфиги или вообще чего изволите-с).

# Подробнее о моих скилах в моих резюме:
# https://hh.ru/applicant/resumes/view?resume=7f254038ff0bc56c180039ed1f4e36456b4942 
# https://hh.ru/applicant/resumes/view?resume=331e6674ff0bce7db60039ed1f365267506d34 (этим я  откликался на вакансию)
# https://career.habr.com/ilya_smolyaninov

# Мой гит(тут пока ничего нет, но будет появляться по мере появления осмысленных кусков кода в моем портфолио):
# https://github.com/IliaSmolianinov

# Буду весьма признателен за обратную связь(по заданию в частности, и по отклику в целом).
# +7 904 550 55 74 Telegram
# +7 921 189 37 10 Whatsapp
# ilya.smolyaninoff@yandex.ru

# Благодарю за внимание.










