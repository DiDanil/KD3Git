if ! grep -q "/KD3Git" .gitignore; then	
	echo -e "\n/KD3Git" >> .gitignore
fi

if ! [ -d "KD3Git" ]; then 
	git clone ../KD3Git.git KD3Git 
else
	cd KD3Git
	git pull origin main
fi

