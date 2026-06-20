.PHONY: quadlets

quadlets: docker-compose.yaml
	@/bin/mkdir -p systemd
	@/bin/rm -f systemd/*
	podlet --install --file systemd compose --pod
