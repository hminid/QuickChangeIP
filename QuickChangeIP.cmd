:: Copyright (c) 2023-2024 hminid <https://github.com/hminid/QuickChangeIP>
:: �ļ�����QuickChangeIP.cmd 
:: �ýű���Ҫ����ԱȨ��
:: "������������" Ϊ��Ҫ����IP���������������ʵ����������޸�

title QuickChangeIP �����л�IP
@echo off
cls
echo.

:set_default
set eth="������������"
set netmask=255.255.255.0
set dns1=223.6.6.6
set dns2=223.5.5.5

::1#
set ip_[1]=192.168.1.2
set gw_[1]=192.168.1.8

::2#
set ip_[2]=192.168.1.2
set gw_[2]=192.168.1.16

::3#
set ip_[3]=192.168.0.2
set gw_[3]=192.168.0.1

::4#
set ip_[4]=10.0.0.2
set gw_[4]=10.0.0.1

:start
echo +++++++++++++++�������ԱȨ��!!!
echo +  ���  IP��ַ  
echo +   0  DHCP
echo +   1  %ip_[1]% gateway=%gw_[1]%
echo +   2  %ip_[2]% gateway=%gw_[2]%
echo +   3  %ip_[3]% gateway=%gw_[3]%
echo +   4  %ip_[4]% gateway=%gw_[4]%
echo +   9  ��������(�س�ֱ���˳�)
echo.

:choice
set choice=
set /p choice=��ѡ��:[0,1,2,3,4,9]?
if %choice%==0 (goto do_dhcp)
if %choice%==1 (set ip=%ip_[1]% & set gw=%gw_[1]% &	goto do_static )
if %choice%==2 (set ip=%ip_[2]% & set gw=%gw_[2]% &	goto do_static )
if %choice%==3 (set ip=%ip_[3]% & set gw=%gw_[3]% &	goto do_static )
if %choice%==4 (set ip=%ip_[4]% & set gw=%gw_[4]% &	goto do_static )
if %choice%==9 (goto end)  else (echo ����������������� & goto choice )

:do_dhcp
echo ����IP��ַ�Զ���ȡ(dhcp)
netsh interface ip set address name=%eth% source=dhcp
netsh interface ip set dns name=%eth% source=dhcp
goto end

:do_static
echo ��� (%choice%)
echo ip= %ip%
echo gw= %gw%
echo dns1=%dns1%
netsh interface ip set address name=%eth% source=static addr=%ip% mask=%netmask% gateway=%gw%
netsh interface ip set dns name=%eth% source=static addr=%dns1% register=primary
goto end

:end
@echo on
@pause