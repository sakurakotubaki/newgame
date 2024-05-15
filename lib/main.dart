import 'dart:math'; // 追加

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewGame(),
    );
  }
}

class NewGame extends StatefulWidget {
  const NewGame({super.key});

  @override
  State<NewGame> createState() => _NewGameState();
}

class _NewGameState extends State<NewGame> {
  List<String> sideDishList = [];

  void _addSideDish(String imagePath) {
    if (sideDishList.length < 3) {
      setState(() {
        sideDishList.add(imagePath);

        if (sideDishList.length == 3) {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration:
                  const Duration(milliseconds: 1000), // アニメーションの時間を設定
              pageBuilder: (_, __, ___) =>
                  NextScreen(sideDishList: sideDishList),
              transitionsBuilder: (_, animation, __, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0), // 右から左にスライド
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            ),
          ).then((_) {
            // 画面遷移から戻ってきたらリセットする
            setState(() {
              sideDishList.clear();
            });
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 203, 214), // 背景色を設定
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 236, 140, 172), // AppBarの背景色を青色に設定
        title: const Text('今日のお弁当'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 垂直方向の中央寄せ
        children: [
          const Text(
            'おかずを３つ選んでね🍽️',
            style: TextStyle(fontSize: 26),
          ),
          const SizedBox(height: 30),
          Stack(
            children: [
              Image.asset('assets/お弁当箱.png'),
              Positioned(
                top: 88.0, // おかずの上端からのオフセット
                left: 0.0,
                right: 0.0,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: sideDishList
                      .map(
                        (e) => Image.asset(e),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 36), // おかずボタングループとお弁当箱の間のスペース
          Align(
            alignment: Alignment.center,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 8.0,
              children: [
                GestureDetector(
                  onTap: () {
                    _addSideDish('assets/ウインナー.png');
                  },
                  child: Image.asset('assets/ウインナー.png'),
                ),
                GestureDetector(
                  onTap: () {
                    _addSideDish('assets/おにぎり.png');
                  },
                  child: Image.asset('assets/おにぎり.png'),
                ),
                GestureDetector(
                  onTap: () {
                    _addSideDish('assets/トマト.png');
                  },
                  child: Image.asset('assets/トマト.png'),
                ),
                GestureDetector(
                  onTap: () {
                    _addSideDish('assets/ブロッコリー.png');
                  },
                  child: Image.asset('assets/ブロッコリー.png'),
                ),
                GestureDetector(
                  onTap: () {
                    _addSideDish('assets/卵焼き１.png');
                  },
                  child: Image.asset('assets/卵焼き１.png'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  const NextScreen({super.key, required this.sideDishList});

  final List<String> sideDishList;


  @override
  Widget build(BuildContext context) {
    // ランダムに１種類の画像を選択
    String randomImage = selectRandomImage();

    // 画像と対応するテキストのマップ
    Map<String, String> imageTextMap = {
      'assets/お弁当屋さん.png': '友達が奢ってくれるよ！',
      'assets/ハンバーグ弁当.png': 'やったー！\nハンバーグ弁当だ🍴',
      'assets/空のお弁当.png': 'ざんねん…\n誰かに食べられちゃった\nみたい',
      'assets/唐揚げ弁当.png': '母の唐揚げ弁当🤱',
      'assets/日の丸弁当.png': '日の丸弁当🇯🇵',
      'assets/幕の内弁当.png': '大当たり！\n幕の内のお弁当🎯',
    };

    String imageText = imageTextMap[randomImage] ?? 'テキストがありません';

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 203, 214), // 背景色を設定
      appBar: AppBar(
        backgroundColor:
            const Color.fromARGB(255, 236, 140, 172), // AppBarの背景色を青色に設定
        title: const Text('完成！'),
        // 戻るボタンを非表示にする
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              imageText,
              style: const TextStyle(fontSize: 30),
              textAlign: TextAlign.center, // テキストを中央揃えにする
            ),
            const SizedBox(height: 20), // 画像とテキストの間のスペース
            Image.asset(randomImage),
            const SizedBox(height: 20), // 画像とボタンの間のスペース
            ElevatedButton(
              onPressed: () {
                // 画面を閉じて前の画面に戻る
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // ボタンの背景色を緑色に設定
              ),
              child: const Text('おかず選びに戻る'),
            ),
          ],
        ),
      ),
    );
  }

  // ランダムに1つの画像を選択する関数
  String selectRandomImage() {
    List<String> imageList = [
      'assets/お弁当屋さん.png',
      'assets/ハンバーグ弁当.png',
      'assets/空のお弁当.png',
      'assets/唐揚げ弁当.png',
      'assets/日の丸弁当.png',
      'assets/幕の内弁当.png',
    ];

    Random random = Random();
    int randomNumber = random.nextInt(imageList.length);
    return imageList[randomNumber];
  }
}
