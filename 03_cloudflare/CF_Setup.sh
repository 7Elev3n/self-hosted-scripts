## Follow https://old.reddit.com/r/homelab/comments/pnto6g/how_to_selfhosting_and_securing_web_services_out/

# Run as (sudo user)

# 1 Install cloudflared (its meant for focal but works on impish)
echo 'deb http://pkg.cloudflare.com/ focal main' | sudo tee /etc/apt/sources.list.d/cloudflare-main.list

curl -C - https://pkg.cloudflare.com/pubkey.gpg | sudo apt-key add -
sudo apt update
sudo apt install cloudflared

mkdir /etc/cloudflared

# 2 Authenticate
cloudflared tunnel login

# 3 Create tunnel
cloudflared tunnel create xyzroot

# 4 Make /etc/cloudflared/config.yml, replace codes below with json filename.

		tunnel: bb46eb94-dd62-49a9-acbc-3936d4804782
		credentials-file: /etc/cloudflared/bb46eb94-dd62-49a9-acbc-3936d4804782.json
		originRequest:
		  originServerName: steech.xyz
		ingress:
		  - hostname: '*.steech.xyz'
		    service: https://localhost
		  - service: https://localhost:404


# 5 Route
cloudflared tunnel route dns xyzroot *.steech.xyz

# 6 run tunnel
cloudflared tunnel run

### On another terminal, restart/start up docker compose (detached mode) with SWAG, NC, Mariadb, Redis, etc.
docker compose -f "/home/dockerboi/dcompose-nc.yml" up -d
docker logs -f swag

## To make into service that starts on boot:
# See https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/run-tunnel/as-a-service/linux/
sudo cloudflared service install
sudo systemctl start cloudflared

sudo systemctl status cloudflared # to check if service is running/logs.
