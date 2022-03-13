--success

fs.makeDir(jaestd)

os.wget https://raw.githubusercontent.com/TylenolWasTaken/jaestd/master/jaestd/networking.lua jaestd/networking.lua
os.wget https://raw.githubusercontent.com/TylenolWasTaken/jaestd/master/jaestd/mobility.lua jaestd/mobility.lua
os.wget https://raw.githubusercontent.com/TylenolWasTaken/jaestd/master/jaestd/console.lua jaestd/console.lua

print("Install finished")
rm install.lua