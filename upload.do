redo-ifchange all
AWS_REGION=ap-southeast-2 aws s3 sync --delete --exclude '.redo/*' \
	--acl public-read public s3://prazefarm/ >&2
aws cloudfront create-invalidation --distribution-id E3C8Z7VRIZH2B3 \
	--invalidation-batch "{ \"Paths\": { \"Quantity\": 1, \"Items\": [ \"/*\" ] }, \"CallerReference\": \"$(date +%s)\" }" >&2
