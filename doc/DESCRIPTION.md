Garage is an S3-compatible distributed object storage service designed for self-hosting at a small-to-medium scale.

Garage is designed for storage clusters composed of nodes running at different physical locations, in order to easily provide a storage service that replicates data at these different locations and stays available even when some servers are unreachable. Garage also focuses on being lightweight, easy to operate, and highly resilient to machine failures.

### Features

- S3 API
- Standalone/self-contained
- Flexible topology
- No RAFT slowing you down
- Several replication modes
- Web server for static websites
- Bucket names as aliases
- Cluster administration API
- Metrics and traces
- Support for changing IP addresses
- K2V API (experimental)
