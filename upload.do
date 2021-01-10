redo-ifchange all
aws s3 --profile mine sync --delete \
	--exclude '*.inc' \
	--exclude 'assets' \
	--exclude '.git/*' \
	--exclude 'node_modules/' \
	--exclude '*.html.in' \
	--storage-class STANDARD_IA \
	--acl public-read . s3://prazefarm/ >&2
aws --profile mine s3 sync --cache-control="max-age=86401" --storage-class STANDARD_IA --acl public-read assets s3://prazefarm/assets >&2
aws --profile mine cloudfront create-invalidation --distribution-id E3C8Z7VRIZH2B3 --invalidation-batch "{ \"Paths\": { \"Quantity\": 1, \"Items\": [ \"/*\" ] }, \"CallerReference\": \"$(date +%s)\" }" >&2
