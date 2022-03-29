environment               = "dev"
instance_type             = "t3.small"
certificate_domain_api    = "api.facilittei.com"
certificate_domain_assets = "assets.facilittei.com"
certificate_domain_videos = "videos.facilittei.com"
db_name                   = "facilittei"
cors_allowed_url = [
  "https://api.facilittei.com",
  "https://app.facilittei.com",
  "http://localhost:80",
  "http://localhost:3000"
]
