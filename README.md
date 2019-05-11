Coupon exchange project on LinuxONE

# It's a demo of academic project, airline coupon exhange platform based on hyperledger fabric.
You need request access to the LinuxONE Community Cloud, set up the webapp by scripts. Request access to LinuxONE Community Cloud, please refer to: https://linuxone.cloud.marist.edu/cloud/#/register?flag=vm


Usage:

Once you log in Community Cloud vm, following the steps below to start a webapp locally :

1 git clone https://github.com/coupon-blockchain-bit/scut.git

2 cd scut

3 ./start

4 get the web app in browser by XXX.XXX.XXX.XXX:8080/bonusPointsExchange/, for example: http://148.100.245.73:8080/bonusPointsExchange,

To change the UI, please:

1 cd scut/bonusPointsExchange

2 modify the JSP files

3 cd ../

4 ./build 

5 check the change on XXX.XXX.XXX.XXX:8080/bonusPointsExchange/ in the browser
