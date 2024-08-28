```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80

```


```bash
kubectl rollout history deploy/nginx-deployment
kubectl set image deployment/nginx-deployment nginx=nginx:1.16.2 --record=true
kubectl rollout undo deploy/nginx-deployment --to-revision=2
kubectl get deploy/nginx-deployment -o wide
```
