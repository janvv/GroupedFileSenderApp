# App Group File Communicaiton

This repository provides two apps illustrating how to perform inter-app communicaiton using App Groups.

GroupedFileSenderApp writes continuously fake glucose data to the `glucoseValues.txt` in the "group.kuq" group.
GroupFileReceiverApp observes these changes in realtime. 

## Background
iOS does not provide inter-app communication. Notificaiton Center notificaitons are not broadcasted. In MaCOSX DistributedNotificaitonCenter can be used to send notificaitons between processes. However, this is not available in iOS.
One workaround is using coordinated file writes and observations using App Groups. App Groups are shared direcotries that can be accessed by application that share the same group capability
<img width="648" alt="image" src="https://github.com/janvv/GroupedFileSenderApp/assets/13400913/dd952455-e9fd-47f4-9065-4986f5ecb981">
Apps can write to these common files and observe changes to these files. Another alternative are Darwin notifications. Which are not part of this project (see further reading).

## License

This project is free of use

## Acknowledgments
This code is based on discussions on stackoverflow:
https://stackoverflow.com/questions/27011916/how-to-communicate-between-ios-app-containing-extension-and-extension-not-host
https://stackoverflow.com/questions/64446024/ios-14-nsfilepresenter-not-getting-callbacks-notifications-works-on-ios13

## Further Reading
Darwin Notificaitons:
https://stackoverflow.com/questions/27011916/how-to-communicate-between-ios-app-containing-extension-and-extension-not-host
This repository might do something like this.
https://github.com/p-x9/DistributedNotificationCenter/tree/main
