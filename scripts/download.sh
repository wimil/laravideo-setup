case $install_type in
"encoder")
    git clone https://github.com/wimil/laravideo-encoder.git
    ;;
"storage")
    git clone https://github.com/wimil/laravideo-storage.git
    ;;
"backup")
    git clone https://github.com/wimil/laravideo-backup.git
    ;;
*)
    echo ""
    ;;
esac
