#!/bin/bash

J_INSTALL_DIR=/var/programs/jdk8

URL=$(curl -s http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html | \
    awk "/downloads\['/ && ! /demos/ && /\['files'\]/ && /linux-x64/ && /\.tar\.gz/" | tail -1 | \
    grep -o 'http.*\.tar\.gz') 

AVAILABLE=$(echo $URL | grep -o -P 'jdk-8u.{0,3}' | cut -d "u" -f 2)
CURRENT=$("$J_INSTALL_DIR"/bin/java -version 2>&1 | awk '/version/ {print $3}' | cut -d_ -f 2 | tr -d '"')

echo " URL =$URL="
echo "   CURRENT =$CURRENT="
echo " AVAILABLE =$AVAILABLE="

if [ -z $CURRENT ] || [ $AVAILABLE -gt $CURRENT ]; then
    #cd /var/cache/oracle-jdk8-installer
    cd /tmp
    rm -f jdk-8u"$CURRENT"-linux-x64.tar.gz
    echo wget -c -N --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" $URL
    wget -c -N --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" $URL
    pwd; 
    ls
    tar -xzf jdk-8u"$AVAILABLE"-linux-x64.tar.gz
    rm -rf $J_INSTALL_DIR
    mv jdk1.8.0_"$AVAILABLE"/ $J_INSTALL_DIR

    LATEST=$(LANG=C update-alternatives --display java | grep ^/ | sed -e 's/.* //g' | sort -n | tail -1)
    if [ -z $LATEST ]; then
        LATEST=1
    else
        J_PATH=$(LANG=C update-alternatives --display java | grep "priority "$LATEST"" | awk '{print $1}')
        [ $J_PATH = "$J_INSTALL_DIR"/jre/bin/java ] || LATEST=$((LATEST+1))
    fi  

    #link JRE files
    for f in $J_INSTALL_DIR/jre/bin/*; do
        name=`basename $f`;
echo " name=$name="
#        if [ ! -f "/usr/bin/$name" -o -L "/usr/bin/$name" ]; then  #some files, like jvisualvm might not be links
        if [  -f /sdflkjsflsdf ]; then  #some files, like jvisualvm might not be links
         echo "at 1"
            if [ -f "$J_INSTALL_DIR/man/man1/$name.1.gz" ]; then

           echo one     update-alternatives --install /usr/bin/$name $name $J_INSTALL_DIR/jre/bin/$name $LATEST --slave /usr/share/man/man1/$name.1.gz $name.1.gz $J_INSTALL_DIR/man/man1/$name.1.gz
                update-alternatives --install /usr/bin/$name $name $J_INSTALL_DIR/jre/bin/$name $LATEST --slave /usr/share/man/man1/$name.1.gz $name.1.gz $J_INSTALL_DIR/man/man1/$name.1.gz
            fi
        else     
         echo "at 2"
             echo   update-alternatives --install /usr/bin/$name $name $J_INSTALL_DIR/jre/bin/$name $LATEST
                update-alternatives --install /usr/bin/$name $name $J_INSTALL_DIR/jre/bin/$name $LATEST

        fi
    done

    echo "Oracle Java 8 installed"

fi

if [ $AVAILABLE -eq $CURRENT ]; then
    echo "Java is up to date"
fi
