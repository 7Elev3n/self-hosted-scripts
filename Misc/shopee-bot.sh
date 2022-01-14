git clone https://github.com/7Elev3n/crawler_shopee.git /$HOME/bots/crawler_shopee
cd  /$HOME/bots/crawler_shopee
cp env.py.sample env.py

sed -i 's/username/7elev3n/g' env.py
sed -i 's/"password"/"Civil-Saga2"/g' env.py

docker build . shopee:latest
# this new image is now called shopee or shopee:latest

# docker run -it makes the session interactive, see https://stackoverflow.com/questions/30137135/confused-about-docker-t-option-to-allocate-a-pseudo-tty
docker run -it --rm -v /$HOME/bots/crawler_shopee:/code shopee sh -c "python main.py"
