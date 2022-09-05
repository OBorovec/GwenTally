import 'package:flutter/material.dart';
import 'package:gwentboard/components/_page/side_page.dart';
import 'package:gwentboard/constants/gwent_icons.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SidePage(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: const [
                GwentRules(),
                PackRules(),
                IconDescription(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GwentRules extends StatelessWidget {
  const GwentRules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Gwent rules',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        const Text(
          '- To begin a match, the game selects the starting player with a coin toss.',
        ),
        const Text(
          '- Each player receives 10 random cards pulled from their decks. Players can discard two cards and redraw in the hope of receiving two superior cards. This is done once.',
        ),
        const Text(
          '- Players place a Unit Card on the Gwent board in the dedicated combat row. Each player may play one card per turn unless a special ability enables them to do otherwise. Players may also utilize Weather Cards from the Neutral Deck.',
        ),
        const Text(
          '- Each unit Card has Strength points that are added for each player`s total. A player will win a round of Gwent when the player has more points than the other and both players no longer have cards to play or the other player passes their turn.',
        ),
        const Text(
          '- Matches are set with 2 wins out of 3 rounds. This is represented by the Round Points, or red gems, next to each player`s name. Losing a round loses you one of the points, if you lose both you lose the match. A draw makes both players lose a point unless you are the Nilfgaardian Empire.',
        ),
      ],
    );
  }
}

class PackRules extends StatelessWidget {
  const PackRules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Pack building rules',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ],
    );
  }
}

class IconDescription extends StatelessWidget {
  const IconDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Icon description',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        _buildItem(
          Icon(GwentIcons.commanderHorn),
          'Commander horn',
        ),
        _buildItem(
          Icon(GwentIcons.tightBond),
          'Tight bond',
        ),
        _buildItem(
          Icon(GwentIcons.muster),
          'Muster',
        ),
        _buildItem(
          Icon(GwentIcons.moral),
          'Moral',
        ),
        _buildItem(
          Icon(GwentIcons.doubleMoral),
          'Double moral',
        ),
        _buildItem(
          ImageIcon(
            GwentIcons.scorch,
            color: Colors.white,
          ),
          'Scorch',
        ),
      ],
    );
  }

  Row _buildItem(Widget icon, String text) {
    return Row(
      children: [
        icon,
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
