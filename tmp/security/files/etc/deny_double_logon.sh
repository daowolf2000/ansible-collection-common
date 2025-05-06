#!/bin/bash

#Выполняет проверку, что текущий пользователь подключен только с текущего АРМ
#Вызывается при входе в систему любого пользователя из /etc/profile
my_login=`whoami`

#root входит только во время НШС, его пароль разделен, и он не является персонифицированной УЗ
if [ $my_login == 'root' ]; then exit; fi
if [ `who | grep $my_login | wc -l` -lt '2' ]; then exit; fi

#Текущий процесс - /bin/bash /etc/no_double_logins.sh
#Определим PID процесса, родительского ему - bash.
current_process_ppid=`ps -ef | grep "no_double_logins.sh" | grep -v grep | grep -v "ps -ef" | head -1 | awk '{ print $3 }'`

#Следующий шаг - PID процесса, родительского для bash - инстанса sshd, который обслуживает нашу сессию
sshd_pid=`ps -ef | grep $current_process_ppid | grep -v "ps -ef" | grep -v grep | head -1 | awk '{ print $3 }'`

#Зная PID процесса sshd, определяем терминал, на котором работаем
my_terminal=`ps -ef | grep $sshd_pid | grep sshd | awk '{ print $9 }' | awk -F '@' '{ print $2 }'`

#Зная терминал, на котором работаем, определяем IP, с которого подключились к системе
my_ip=`who | grep "$my_terminal" | awk '{ print $5 }' | cut -c 2- | rev | cut -c 2- | rev`
       
if [ `who | grep $my_login | wc -l` -ne `who | grep $my_ip | wc -l` ]
then
#Количество логинов с текущего IP не совпадает с общим количеством логинов - значит, в системе уже есть сессии от IP, отличного от текущего
	printf "Вход невозможен. Ваш пользователь уже подключен к системе."
	existing_ips=`who | grep $my_login | awk '{ print $5 }' | cut -c 2- | rev | cut -c 2- | rev | grep -v $my_ip | sort | uniq`
	echo $existing_ips
	logger "User $my_login denied login from ${my_ip}: already logged on from $existing_ips."
	sleep 10
	kill -6 $current_process_ppid
	exit 1
fi
exit 0
