 wget --no-check-certificate https://github.com/mkm-77/as-os -O- | grep 'href="/mkm-77/as-os/tree/master/' |sed s/'<.*open "'// | sed s/'title=".*id'// | sed s/'=.* '//| sed s/'class=".*"'//
