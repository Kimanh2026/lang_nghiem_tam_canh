import 'package:flutter/material.dart';

class TeachingsScreen extends StatefulWidget {
  const TeachingsScreen({super.key});

  @override
  State<TeachingsScreen> createState() => _TeachingsScreenState();
}

class _TeachingsScreenState extends State<TeachingsScreen> {
  int _selectedChipIndex = 0;
  String _searchQuery = '';
  
  List<String> get _filters => ['Hòa Thượng Tuyên Hóa', 'Hòa Thượng Phổ Quang'];

  List<Map<String, String>> get _allTeachings => [
    // --- KHAI THỊ CŨ ---
    {
      'title': 'Cột Mốc 36.000 Biến & Đài Sen Nâng Đỡ',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': 'Khi một hành giả chí tâm trì tụng đạt tới cột mốc tối thượng 36.000 biến, những phép mầu hiện tiền sẽ hóa sinh. Tích lũy đủ 36.000 lần một cách chuẩn xác, một hiện tượng vi diệu sẽ xuất hiện: dưới thân người đó sẽ hiện ra một đài sen nâng đỡ trong khoảng không vô hình.',
    },
    {
      'title': 'Định Quốc Vãng Sinh — 36.000 Đạo Hào Quang',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': 'Mỗi biến Chú Lăng Nghiêm được tụng lên giống như việc vẽ một đạo hào quang rực rỡ bao bọc xung quanh cơ thể. Do đó, khi tụng đủ 36.000 biến, thân tâm hành giả sẽ có 36.000 đạo hào quang kiên cố bảo vệ, chắc chắn thoát khỏi ba đường ác nghiệp.',
    },
    {
      'title': 'Cứu Độ Cha Mẹ Trong Bảy Đời Nhiều Kiếp',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': 'Năng lực của 36.000 biến tụng không chỉ đem lại sự thành tựu riêng cho bản thân, mà còn tỏa năng lượng cứu độ to lớn. Công đức thù thắng này có thể giúp cứu độ cha mẹ trong bảy đời, thậm chí là cha mẹ trong nhiều kiếp quá khứ đều được giải thoát siêu sinh.',
    },
    {
      'title': 'Sự Tồn Vong Của Chánh Pháp',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview': 'Chú Lăng Nghiêm là linh văn cứu mạng của trời đất. Bất cứ lúc nào cũng phải có người trì tụng Chú Lăng Nghiêm để chống đỡ trời đất, không để cho thế giới đi đến chỗ hoại diệt. Nếu không còn ai tụng Chú Lăng Nghiêm nữa, thế giới này sẽ nhanh chóng đi đến cõi diệt.',
    },
    {
      'title': 'Cảnh Giới Thân Kim Cang Bất Hoại',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': 'Quá trình tinh tấn trì tụng đại thần chú giúp trược khí giảm sâu, thanh khí thăng tiến, chuyển hóa phàm thân thành Thân Kim Cang. Cơ thể trở nên cứng chắc như đồng sắt, hàm răng 36 chiếc tự mọc lại, và thân thể tự tỏa mùi hương đàn hương nồng nàn bất biến.',
    },
    {
      'title': 'Bách Độc Bất Sâm & Thần Thông Muông Thú',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': 'Thân thể miễn nhiễm hoàn toàn với tất cả bệnh tật, độc chất. Đặc biệt, khi hành giả trì tụng vượt qua mốc 1.000.000 biến, họ sẽ đắc được khả năng thấu hiểu ngôn ngữ của muôn loài động vật, thoát khỏi thế giới hư ảo huyễn cảnh.',
    },
    {
      'title': 'Vì Sao Trì Lăng Nghiêm Chú Phải Niệm Lớn Tiếng',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': 'Phàm là người đến Quan Âm Cổ Động tu hành thì nhất định phải niệm lớn tiếng. Vì sao thầy kêu các Phật tử niệm lớn tiếng? Niệm lớn tiếng Lăng Nghiêm Chú, thì hoa sen của các Phật tử cũng lớn theo. Niệm cho tốt thì cha mẹ đều được lợi ích, đều được ngồi trên hoa sen. Các Phật tử xem Thích Ca Mâu Ni Phật, Dược Sư Phật, A Di Đà Phật trong Đại Hùng Bảo Điện, các Ngài đều ngồi trên hoa sen 5 tầng.\n\nNiệm lớn tiếng Lăng Nghiêm Chú không chỉ có lợi cho bản thân. Nó còn có thể đả thông toàn bộ kinh mạch trong thân thể. Niệm lớn tiếng thì sẽ không còn đủ thứ vọng tưởng nữa.\n\nVì sao cả đời thầy không cho phép mặc niệm và niệm nhỏ tiếng? Niệm Lăng Nghiêm Chú phải hét to ra, âm thanh càng lớn càng tốt. Thầy thích nhất là người có âm thanh lớn. Khi hét to ra rồi, thì thân và tâm của Phật tử đều ở trong câu chú, sẽ không đi khởi vọng tưởng nữa. Đủ thứ bệnh tật cũng không còn. Cũng sẽ không có 50 loại ấm ma. Ấm ma là gì? Chính là tà tư tà kiến trong tâm của chính mình, như vậy là bị ma ám rồi.\n\nNiệm lớn tiếng Lăng Nghiêm Chú, hết thảy ma đều không còn. Chúng nó từ xa đều quỳ xuống dập đầu đảnh lễ Phật tử. Cho đến những con trùng con kiến, tất cả chúng sinh, chỉ cần nghe được thôi, vị lai đều sẽ thành Phật.\n\nMỗi một chữ mỗi một câu của Lăng Nghiêm Chú đều là phá địa ngục. Những chúng sinh đang chịu khổ trong địa ngục đều có thể được độ. Cho nên uy lực của Lăng Nghiêm Chú chính là lớn như vậy đó.',
    },
    {
      'title': 'Cấu Trúc Khởi Đầu Của Bài Tụng',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': 'Để bài trì chú có hiệu quả tốt nhất, tuyệt đối không nên bỏ qua nghi thức khởi đầu: Luôn phải niệm 3 lần câu "Đại Phật Đảnh Thủ Lăng Nghiêm Thần Chú". Câu này giống như cái đầu, phần thần chú là thân thể; nếu không tụng giống như cơ thể không có đầu.',
    },
    {
      'title': 'Sự Bảo Vệ Của 8 Vạn 4 Ngàn Kim Cang Tạng',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview': 'Bạn tụng Chú Lăng Nghiêm, dù bạn chỉ tụng một chữ, một câu, một hội, hay toàn bộ, thì tám vạn bốn ngàn Kim Cang Tạng Bồ Tát cùng quyến thuộc của các ngài cũng luôn luôn theo bảo vệ bạn cẩn thận, không để cho bất kỳ loài ma quỷ nào đến quấy nhiễu.',
    },
    {
      'title': 'Không Nên Ăn Trứng Khi Trì Chú',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': 'Không nên ăn trứng khi trì tụng Chú Lăng Nghiêm. Việc ăn trứng gà mang tội nặng hơn cả ăn thịt thông thường, bởi lẽ mỗi quả trứng đại diện cho một sinh mạng nguyên vẹn. Ăn trứng mang mùi tanh, ngăn cản thân tâm đạt đến thuần tịnh Lăng Nghiêm Tam Muội.',
    },
    {
      'title': 'Bảo Pháp Ngũ Đại Tâm Chú Cho Người Bận Rộn',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': 'Nếu không đủ thời gian trì toàn bộ, hãy tụng Ngũ Đại Tâm Chú: SẤT ĐÀN NỂ — A CA GIA — MẬT RỊ TRỤ — BÁT RỊ ĐÁT RA GIA — NẢNH YẾT RỊ. Chỉ cần trì 7 biến hằng ngày, công đức tạo ra còn to lớn hơn cả việc trì tụng đủ 108 biến Chú Đại Bi tinh tấn.',
    },
    {
      'title': 'Hàng Phục Ma Quân',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview': 'Chú Lăng Nghiêm là thần chú uy lực nhất để hàng phục ma oán. Khi bạn tụng Chú Lăng Nghiêm, tất cả tà ma ngoại đạo, yêu ma quỷ quái đều khiếp sợ và không dám đến gần. Đó là vì Chú Lăng Nghiêm phát ra hào quang rực rỡ của Phật, soi sáng khắp pháp giới.',
    },

    // --- KHAI THỊ MỚI (NGUYÊN VĂN) ---
    {
      'title': 'Vụ Trứng Gà',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview': '“Bạn cho rằng ăn chay thì ăn trứng cũng được? Cũng được! Chờ tới khi bạn đầu thai làm gà rồi khi đó bạn sẽ hiểu (phận làm gà) chính do ăn trứng gà mà ra”.\n\nHỏi: Là đệ tử Phật thì có thể ăn trứng không?\nĐáp: Nếu quý vị thèm muốn ăn những thứ dinh dưỡng đó, thì cần gì phải hỏi tôi?\n\nHỏi: Tại sao người ăn chay không được ăn trứng?\nĐáp: Không có gà trống, gà mái cũng có thể ấp trứng nở ra gà con như thường. Ngày xưa người ta không hiểu điều này nên họ nói là, nếu trứng không có trống thì không thể nở ra gà con. Nhưng lối nói này cũng không đúng sự thật. Bởi vì đạo lý vốn không có tuyệt đối, cho nên chúng ta ăn chay quyết không nên ăn trứng.\n\nHỏi: Lúc ăn chay có thể ăn trứng gà không?\nĐáp: Bạn chưa ăn đã muốn biết! Cùng với không ăn thì thế nào? Ăn thì thế nào?',
    },
    {
      'title': 'Sự Bảo Vệ Của Ngàn Đóa Hoa Sen',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview': 'Hai mươi chín câu Chú đầu tiên, một khi niệm ra thì sẽ xuất hiện một cảnh giới là: bốn mặt tám phương có rất nhiều hoa sen đỏ đến ủng hộ người trì Chú này, cho nên nói: "Ngàn đóa sen đỏ hộ người trì." (Thiên đóa hồng liên hộ trụ thân). Tám vạn bốn ngàn Kim Cang tạng Bồ tát cũng đến gia hộ bạn, cho nên nói: "Ngồi trên hoa sen đi mây trắng" (Tọa liên phi thừa bạch vân đôn). Câu Chú này (Nam Mô Tát Đát Tha) vốn dĩ bảo hộ người tụng, ai mà trì câu Chú này thì Ma vương Ba Tuần không có cách gì lại gần được.',
    },
    {
      'title': 'Tại Sao Người Ta Muốn Tự Sát?',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview': 'Tôi nói cho quý vị biết, những người tự sát đa số đều bị ma quỷ kêu họ đến đó. Con quỷ đó đối với người tự sát đã niệm một bài chú. Quỷ niệm chú gì? Nó nói: “Mày đi chết đi! Mày đi chết đi! Chết đi là tốt lắm! Chết đi là tốt nhất đó!”. Con quỷ đó có tha tâm thông, nó lấy quỷ khí xâm nhập vào tâm của người đó khiến người đó nghĩ rằng: “A! Chết đi là tốt! Chết đi là tốt!”. Thế là người đó bèn đi uống thuốc độc tự tử, treo cổ, nhảy xuống biển... Vì vậy bất cứ lúc nào, mọi người cần phải niệm Phật, niệm chú. Quý vị niệm Phật niệm chú thì lúc đó có Phật quang phổ chiếu, ma quỷ sẽ bỏ chạy đi mất.',
    },
    {
      'title': 'Bồ Tát Kim Cang Tạng Âm Thầm Thúc Giục',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview': 'Giả sử tâm niệm của quý vị vô cùng tán loạn, không thể chuyên nhất, nhưng nếu miệng của quý vị liền trì tụng Chú Lăng Nghiêm, thì Bồ Tát Kim Cang Tạng Vương liền dùng tâm tinh chân thuần thục đi theo âm thầm thúc giục. Chữ “âm thầm thúc giục” này vô cùng quan trọng, có nghĩa là ở phía sau âm thầm đẩy bạn một cái, âm thầm hướng dẫn bạn, nhắc nhở bạn. Khiến tâm tán loạn của quý vị dần mất đi, một chút, một chút một sinh ra định lực, rồi đạt được định lực, dần dần quý vị sẽ được khai mở trí huệ.',
    },
    {
      'title': 'Trì Chú Lăng Nghiêm Nhất Tâm',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview': 'Khi tụng Chú Lăng Nghiêm không nên có tâm mong cầu, không mong cầu đắc thần thông, không mong cầu đắc Phật nhãn, không mong cầu tiêu tai, không mong cầu khỏi bệnh... Chỉ cần nhất tâm tụng trì, thì công đức mới lớn. Giống như đứa trẻ bú mẹ, chỉ biết bú thôi chứ đâu có nghĩ gì khác. Bú no rồi thì ngủ, ngủ dậy lại bú. Người tụng chú cũng phải như thế, không được có một vọng niệm nào xen vào.',
    },
    {
      'title': 'Không Ăn Ngũ Vị Tân',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview': 'Đức Phật dạy trong Kinh Lăng Nghiêm: Các chúng sinh cầu quả Bồ Đề, cốt yếu là không được ăn ngũ vị tân (hành, tỏi, nén, hẹ, hưng hào). Vì năm thứ vị cay này, ăn chín thì phát dâm, ăn sống thì thêm phẫn nộ. Những người ăn năm thứ vị cay này, tuy có tụng trì mười hai bộ kinh Phật, mười phương Thiên tiên cũng đều chê mùi hôi thối mà tránh xa. Các ngạ quỷ sẽ thường liếm môi miệng của người ấy, do luôn sống chung với quỷ nên phước đức ngày càng tiêu mòn, chẳng lợi ích gì.',
    },
    {
      'title': 'Cảnh Giới Nhiệm Màu',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': 'Khi niệm câu "Nam Mô Lăng Nghiêm Hội Thượng Phật Bồ Tát" đủ ba lần, trên hư không bỗng hiện ra một Đàn thành Lăng Nghiêm rộng lớn đến mức không thấy biên giới. Đàn thành ấy như một cái ô khổng lồ bằng ánh sáng bao phủ từ trên không trung xuống. Bên trong Đàn thành có vô số chư Phật, chư Đại Bồ Tát cùng tám vạn bốn ngàn Kim Cang Tạng Bồ Tát. Tất cả các Ngài đều phóng ra đủ thứ hào quang vô cùng rực rỡ và vi diệu, chiếu rọi khắp nơi và gia trì cho tất cả mọi người. Sự hiện diện và ánh sáng từ Đàn thành không chỉ bảo vệ mà còn đem lại lợi ích lớn lao cho những ai thành tâm trì tụng, giúp họ tiêu trừ nghiệp chướng, tâm trí thanh tịnh và ngày càng tinh tấn trên con đường tu hành.',
    },
    {
      'title': 'Tâm Của Phật - Thân Của Phật',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': 'Bạch ân sư Phổ Quang! Thần Chú Lăng Nghiêm tại sao lại có sức mạnh lớn như vậy ạ?\nHT. Phổ Quang: Thần Chú Lăng Nghiêm này là pháp môn thù thắng nhất trong các pháp môn. Bởi vì nó chính là tâm của Phật, là thân của Phật. Không có thần Chú Lăng Nghiêm, thì không có tất cả chư Phật! ... Con người nếu thật sự hiểu được điều này, thì đã không còn là phàm phu nữa rồi! Niệm đủ 36.000 biến, dưới hai bàn chân của con cũng có hoa sen, khi con đi đứng, thực ra là có hoa sen nâng đỡ, chỉ là nhục nhãn của con nhìn không thấy mà thôi.',
    },
    {
      'title': 'Cảnh Giới Đại Tự Tại',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': 'Có câu: "Làm người thì hiếm khi khờ khạo", nhưng tu hành thì phải đảo ngược lại! Tu hành là phải học cách khờ khạo... Nếu như bạn chẳng có trí tuệ, bạn sẽ chẳng thể khờ khạo được. Giống như Bồ Tát Bố Đại vậy, Ngài khờ nhưng mà Ngài lại sống rất sung sướng! Sống trên đời đừng bao giờ dằn vặt người khác, cũng đừng dằn vặt chính mình! Chuyện lúc tám giờ thì đến chín giờ là phải quên đi rồi. Để những chuyện phiền não đó trong lòng làm chi? Việc gì đã qua thì cứ để nó qua đi! Đó mới là Phật, Bồ-tát, đó mới là khai đại ngộ! Cho nên phải niệm Chú Lăng Nghiêm, niệm Chú Lăng Nghiêm mới có thể có định lực, mới có thể khai mở trí tuệ, một đời thành Phật đạo.',
    },
    {
      'title': 'Công Đức Bằng 10 Toa Tàu Hỏa Kinh Đại Tạng',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': 'Kinh Đại Tạng nhiều như vậy, niệm tới bao giờ mới hết? Nhưng niệm một biến chú Lăng Nghiêm thì công đức bằng cả niệm 10 toa tàu hỏa đầy ắp kinh Đại Tạng! Ai muốn tụng hết bộ kinh Đại Tạng thì thà niệm một biến chú Lăng Nghiêm còn hơn. Có người tu thiền, có người niệm Phật, có người trì chú... có tới 8 vạn 4 ngàn pháp môn, nhưng cho dù có tu pháp nào đi nữa, cũng chẳng bằng chuyên tâm tu một mình chú Lăng Nghiêm. Cho nên, ai tu được chú Lăng Nghiêm, người đó thật sự là có đại phúc báo!',
    },
    {
      'title': 'Siêu Độ Cho Người Đã Khuất',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': 'Có người hỏi về cách siêu độ cho người thân đã khuất. Hòa thượng Phổ Quang đáp: Khi vừa niệm chú, bạn phải vừa quán tưởng lại gương mặt với ngũ quan đang mỉm cười lúc sinh tiền của người chết. Cứ nhất tâm niệm như vậy thì dưới chân thần thức của người mất sẽ lập tức hiện ra một đóa hoa sen, người mất tự nhiên sẽ nhận được lợi ích siêu thoát.',
    },
    {
      'title': 'Niệm Lăng Nghiêm Chú Như Đi Thang Máy',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': 'Mọi người cùng nhau niệm Lăng Nghiêm Chú thì thế giới sẽ bình yên, đất nước sẽ tai qua nạn khỏi.\n\nMỗi bộ kinh chia ra rất nhiều phần. Đọc cả đời cũng không hết. Nhưng Lăng Nghiêm Chú đã bao gồm hết tất cả kinh điển rồi. Kinh Tâm Kinh chính là phần tinh túy nhất của tất cả kinh. Là để cho mình hiểu và ngộ ra.\n\nNiệm A Di Đà Phật thì thoát được sinh tử, nhưng phải thật nhất tâm, tâm phải thật sạch. Tham, sân, si, kiêu mạn, nghi ngờ... mỗi chữ là một cảnh. Sẽ đọa vào đường A Tu La, đường ngạ quỷ... rơi vào đường nào thì theo đường đó.\n\nNiệm Đại Bi Chú 108 lần cũng không bằng niệm 1 lần Lăng Nghiêm Chú. Không bằng niệm 7 lần Ngũ Đại Tâm Chú. Đại Bi Chú là để cứu khổ. Niệm đến mức cao nhất thì toàn thân sáng lên, có thể thành Bồ Tát, nhưng vẫn chưa thành Phật được. Muốn thành Phật thì phải niệm Lăng Nghiêm Chú này.\n\nNiệm kinh khác thì phải hồi hướng. Nhưng niệm Lăng Nghiêm Chú này và Kinh Kim Cang thì không cần hồi hướng. Đức Phật đã ấn chứng rồi. Không cần phải làm thêm nữa. Niệm Lăng Nghiêm Chú, một đời này là thành Phật.\n\nNiệm Lăng Nghiêm Chú giống như đi thang máy vậy đó. VÈO một cái là thành Phật rồi!',
    },
    {
      'title': 'Động Từ Bi',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': 'Động Từ Bi, từ xưa đến nay không biết đã có bao nhiêu vị đại đức (bậc tu hành cao thâm) đến đây đóng cửa ẩn tu rồi. Sư phụ là hòa thượng Phổ Quang kể lại rằng, những giọt nước rỉ ra từ khe đá trong động chính là nước mắt của Phật Bồ Tát. Nước này có thể uống chứ không được lãng phí, và còn chữa được bách bệnh. Căn nhà đá nhỏ nhắn, giản dị kia chính là nơi hòa thượng Phổ Quang từng tu hành lúc còn trẻ. Thời Dân Quốc, các vị hòa thượng nổi tiếng như ngài Hư Vân, pháp sư Viên Anh, và hòa thượng Lai Quả cũng đều từng tu hành ở nơi này.',
    }
  ];

  List<Map<String, String>> get _filteredTeachings {
    return _allTeachings.where((teaching) {
      // 1. Check Search Query
      final matchesSearch = _searchQuery.isEmpty ||
          teaching['title']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          teaching['preview']!.toLowerCase().contains(_searchQuery.toLowerCase());
      
      // 2. Check Chip Filter
      final currentFilter = _filters[_selectedChipIndex];
      final matchesFilter = teaching['meta']! == currentFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _filteredTeachings;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Khai Thị & Tín Tâm', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: const Color(0xFF1A0D08),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                const Text('Liên Hoa Hóa Sanh', style: TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(width: 8),
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  backgroundColor: Color(0xFFD4AF37),
                ),
              ],
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: const Color(0x33D4AF37),
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Tìm kiếm lời khai thị...',
                hintStyle: const TextStyle(color: Color(0xFFD1BFAE)),
                filled: true,
                fillColor: const Color(0xFF1A0D08),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0x4DD4AF37)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0x4DD4AF37)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0xFFD4AF37)),
                ),
                prefixIcon: const Icon(Icons.search, color: Color(0xFFD1BFAE)),
              ),
            ),
            const SizedBox(height: 15),
            
            // Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_filters.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text(_filters[index]),
                      selected: _selectedChipIndex == index,
                      onSelected: (bool selected) {
                        if (selected) {
                          setState(() {
                            _selectedChipIndex = index;
                          });
                        }
                      },
                      backgroundColor: const Color(0xFF1A0D08),
                      selectedColor: const Color(0x33D4AF37),
                      labelStyle: TextStyle(
                        color: _selectedChipIndex == index ? const Color(0xFFD4AF37) : const Color(0xFFD1BFAE),
                        fontSize: 13,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: _selectedChipIndex == index ? const Color(0xFFD4AF37) : const Color(0x80D4AF37),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),

            // Teaching List
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(color: Color(0x1AD4AF37), width: 1),
                ),
                child: filteredList.isEmpty 
                ? const Center(
                    child: Text('Không tìm thấy lời khai thị nào.', style: TextStyle(color: Color(0xFFD1BFAE))),
                  )
                : ListView.separated(
                  padding: const EdgeInsets.all(20.0),
                  itemCount: filteredList.length,
                  separatorBuilder: (context, index) => const Divider(color: Color(0x1AFFFFFF), height: 40),
                  itemBuilder: (context, index) {
                    final item = filteredList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item['meta']!,
                          style: const TextStyle(color: Color(0xFFF28C28), fontSize: 13),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item['preview']!,
                          style: const TextStyle(color: Color(0xFFFDF5E6), fontSize: 16, height: 1.6, fontStyle: FontStyle.normal),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
