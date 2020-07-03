cat <<EOF | oc apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: webmethods-production
  labels:
    app: webmethods-production  
---
apiVersion: apps.open-cluster-management.io/v1
kind: Channel
metadata:
  name: webmethods-production
  namespace: webmethods-production
  labels:
    app: webmethods-production
spec:
  type: GitHub
  pathname: https://github.com/waynedovey/acm-webmethods-production.git
---
apiVersion: apps.open-cluster-management.io/v1
kind: PlacementRule
metadata:
  name: webmethods-production-clusters
  namespace: webmethods-production
  labels:
    app: webmethods-production  
spec:
  clusterConditions:
    - type: OK
  clusterSelector:
    matchExpressions: []
    matchLabels:
      environment: production
---
apiVersion: app.k8s.io/v1beta1
kind: Application
metadata:
  name: webmethods-production
  namespace: webmethods-production
  labels:
    app: webmethods-production  
spec:
  componentKinds:
  - group: apps.open-cluster-management.io
    kind: Subscription
  descriptor: {}
  selector:
    matchExpressions:
    - key: app
      operator: In
      values:
      - webmethods-production
---
apiVersion: apps.open-cluster-management.io/v1
kind: Subscription
metadata:
  name: webmethods-production
  namespace: webmethods-production
  labels:
    app: webmethods-production
  annotations:
      apps.open-cluster-management.io/github-path: resources/webmethods
spec:
  channel: webmethods-production/webmethods-production
  placement:
    placementRef:
      kind: PlacementRule
      name: webmethods-production-clusters
      apiGroup: apps.open-cluster-management.io     
EOF
