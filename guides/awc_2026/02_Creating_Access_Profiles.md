## 02_Creating_Access_Profiles.md

1. Navigate to **Access Profiles** in the CCF UI. You will find it under **Profiles* on the left-hand side of the screen menu.
1. Click on the **default** Access Profile.
    - Alternatively, you can create your own Access Profile, but currently CCF will not use it for Data Services, only for the CSK. For Data Services, it will use the **default** access profile.
1. Locate the *SSH Users* section.
1. Click on **+Add**.
1. Define your **SSH User** (e.g., `fcobo`) and paste your corresponding **SSH Public Key**.
1. Save the profile. This ensures your authentication keys are automatically injected into the `~/.ssh/authorized_keys` file on instances upon creation, granting immediate passwordless access.
