docker build -t zipper .

docker run --rm -it -v ~/vscode-extension/.vscode-server:/root/.vscode-server -v ~/code/zipper:/home/project zipper:v0