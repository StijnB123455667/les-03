# Opdracht 6 - Ansible inzetten binnen mijn organisatie

## Inleiding

Binnen een cybersecuritybedrijf kan Ansible worden gebruikt om systemen sneller, consistenter en met minder fouten uit te rollen bij klanten. In een omgeving waar meerdere klanten beheerd worden, is het belangrijk dat servers op dezelfde manier worden ingericht en dat configuraties goed herhaalbaar zijn.

## Omgeving

De omgeving bestaat uit Linux-servers bij klanten. Dit kunnen Ubuntu-servers of Red Hat-servers zijn. Deze systemen worden gebruikt om logging te verzamelen van bijvoorbeeld firewalls, servers, netwerkapparatuur, cloudomgevingen en applicaties. De verzamelde logging wordt daarna doorgestuurd naar een intern ontwikkeld analyseplatform.

Omdat elke klantomgeving anders kan zijn, is standaardisatie belangrijk. Met Ansible kan een basisconfiguratie automatisch worden toegepast, terwijl klant-specifieke instellingen via variabelen kunnen worden aangepast.

## Wat Ansible moet doen

Ansible kan worden ingezet voor de volgende taken:

- Installeren van basispackages
- Aanmaken van gebruikers en SSH-toegang
- Configureren van firewallregels
- Installeren van logging agents
- Configureren van log forwarding
- Installeren van monitoring agents
- Beheren van configuratiebestanden
- Uitvoeren van updates
- Inrichten van periodieke back-ups

Door deze taken in playbooks en roles te zetten, kan dezelfde configuratie op meerdere klantomgevingen worden uitgerold.

## Voordelen

Het grootste voordeel is dat implementaties sneller en betrouwbaarder worden. Een engineer hoeft minder handmatig werk te doen, waardoor de kans op fouten kleiner wordt. Ook is achteraf beter te controleren hoe een server is ingericht, omdat de configuratie in code staat.

Daarnaast maakt Ansible het eenvoudiger om meerdere servers tegelijk te beheren. Als er bijvoorbeeld een wijziging nodig is in de logging-configuratie, kan die wijziging via één playbook naar meerdere systemen worden uitgerold.

## Consequenties en aandachtspunten

Er zijn ook risico's. Een fout in een playbook kan op meerdere systemen tegelijk worden uitgevoerd. Daarom moeten playbooks eerst getest worden in een testomgeving voordat ze bij klanten worden gebruikt.

Daarnaast moet er zorgvuldig worden omgegaan met wachtwoorden, API tokens en SSH keys. Deze gegevens mogen niet hardcoded in een repository staan. Hiervoor kan gebruik worden gemaakt van Ansible Vault of secrets in een CI/CD-platform.

Ook moet duidelijk zijn wie wijzigingen mag maken aan playbooks. Omdat Ansible veel invloed heeft op klantomgevingen, is versiebeheer en review van wijzigingen belangrijk.

## Conclusie

Ansible is zeer geschikt om binnen een cybersecuritybedrijf klantomgevingen sneller en foutlozer op te zetten. Door configuraties als code te beheren, worden installaties beter reproduceerbaar en veiliger. Voorwaarde is wel dat playbooks goed getest worden en dat gevoelige gegevens veilig worden opgeslagen.
