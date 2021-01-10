redo-ifchange all
aws --profile mine s3 sync --delete --exclude '.redo/*' \
	--cache-control=max-age=86401 \
	--acl public-read public s3://prazefarm/ >&2
aws --profile mine cloudfront create-invalidation --distribution-id E3C8Z7VRIZH2B3 \
	--invalidation-batch "{ \"Paths\": { \"Quantity\": 1, \"Items\": [ \"/*\" ] }, \"CallerReference\": \"$(date +%s)\" }" >&2
