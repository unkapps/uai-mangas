import 'package:flutter/material.dart';

class DMCA extends StatelessWidget {
  const DMCA({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('DMCA'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Text(
              'Copyright Infringement Notification',
              style: theme.textTheme.headline4,
            ),
            Text('''

Uai Mangás respects all copyright and license owners and adheres to the Digital Millenium Copyright Act.

- If you are a content owner and would like us to help distribute your content, contact contact us.

- If you would like your content removed from this website, follow the instructions below.

To file a copyright infringement notification with Uai Mangás, you will need to send a written communication that includes substantially the following (please consult your legal counsel or see Section 512(c)(3) of the Copyright Act to confirm these requirements):

1) A physical or electronic signature of a person authorized to act on behalf of the owner of an exclusive right that is allegedly infringed.

2) Identification of the copyrighted work claimed to have been infringed, or, if multiple copyrighted works at a single online site are covered by a single notification, a representative list of such works at that site.

3) Identification of the material that is claimed to be infringing or to be the subject of infringing activity and that is to be removed or access to which is to be disabled, and information reasonably sufficient to permit the service provider to locate the material. Providing a screenshot in the body of an email is the best way to help us locate content quickly.

4) Information reasonably sufficient to permit the service provider to contact the complaining party, such as an address, telephone number, and, if available, an electronic mail address at which the complaining party may be contacted.

5) A statement that the complaining party has a good faith belief that use of the material in the manner complained of is not authorized by the copyright owner, its agent, or the law.

6) A statement that the information in the notification is accurate, and under penalty of perjury, that the complaining party is authorized to act on behalf of the owner of an exclusive right that is allegedly infringed.

Such written notice should be sent to our designated agent as follows:

DMCA Complaints
Uai Mangás
Email: unkappsbr@gmail.com
Please also note that under Section 512(f) any person who knowingly materially misrepresents that material or activity is infringing may be subject to liability.
'''),
            Text(
              'Counter-Notification',
              style: theme.textTheme.headline4,
            ),
            Text(
              '''

If you elect to send us a counter notice, to be effective it must be a written communication provided to our designated agent that includes substantially the following (please consult your legal counsel or see 17 U.S.C. Section 512(g)(3) to confirm these requirements):

1) A physical or electronic signature of the subscriber.

2) Identification of the material that has been removed or to which access has been disabled and the location at which the material appeared before it was removed or access to it was disabled.

3) A statement under penalty of perjury that the subscriber has a good faith belief that the material was removed or disabled as a result of mistake or misidentification of the material to be removed or disabled.

4) The subscriber's name, address, and telephone number, and a statement that the subscriber consents to the jurisdiction of Federal District Court for the judicial district in which the address is located, or if the subscriber's address is outside of the United States, for any judicial district in which the service provider may be found, and that the subscriber will accept service of process from the person who provided notification under subsection (c)(1)(C) or an agent of such person.

Such written notice should be sent to our designated agent as follows:

DMCA Complaints
Uai Mangás
Email: unkappsbr@gmail.com
Please note that under Section 512(f) of the Copyright Act, any person who knowingly materially misrepresents that material or activity was removed or disabled by mistake or misidentification may be subject to liability. Please also be advised that we enforce a policy that provides for the termination in appropriate circumstances of subscribers who are repeat infringers.
            ''',
            ),
          ],
        ),
      ),
    );
  }
}
