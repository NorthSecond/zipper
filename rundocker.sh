docker build -t zipper .

docker run --rm -it -v ~/vscode-extension/.vscode-server:/root/.vscode-server -v ~/code/zipper:/home/project zipper:v0

docker run --rm -it -d -v ~/vscode-extension/.vscode-server:/root/.vscode-server -v ~/code/zipper:/home/project zipper:0.1.0

docker run --rm -it -d -v ~/code/zipper:/home/project zipper:0.1.0