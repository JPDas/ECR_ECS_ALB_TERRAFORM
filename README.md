
<img width="1016" height="612" alt="Screenshot 2025-08-16 130535" src="https://github.com/user-attachments/assets/8bbb1796-6968-4a98-9f52-5050db299c2e" />


1. Create OIDC in AWS IAM with below configuration 
  Provider: https://token.actions.githubusercontent.com
  Audience: sts.amazonaws.com
2. Create One new IAM role with below trust relations. For ease of access, we will create the role with Admin privileged. 
    Please keep in mind this is not  the correct way of doing in prod. In prod use least privileges for the role.
  Identity provider: https://token.actions.githubusercontent.com
  Audience: sts.amazonaws.com
  GitHub organization: <your organization>. In my case it is JPDas. https://github.com/JPDas/
  Name: github-actions-role
  replace: your_account_id and your_repo
