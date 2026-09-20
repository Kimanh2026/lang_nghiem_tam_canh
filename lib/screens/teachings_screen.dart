import 'package:flutter/material.dart';

import '../theme/app_palette.dart';

class TeachingsScreen extends StatefulWidget {
  const TeachingsScreen({super.key});

  @override
  State<TeachingsScreen> createState() => _TeachingsScreenState();
}

class _TeachingsScreenState extends State<TeachingsScreen> {
  int _selectedChipIndex = 0;

  List<String> get _filters => ['Hòa Thượng Tuyên Hóa', 'Hòa Thượng Phổ Quang'];

  List<Map<String, String>> get _allTeachings => [
    {
      'title': 'Thời Đại “Vô Cùng Nguy Ngập”',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview':
          '''Hơn phân nửa nhân loại sẽ bị hủy diệt, và những người sống sót là những người biết tu Đạo, những người chân thật tu hành, những người biết niệm Phật, những người biết tụng Kinh và những người ăn chay, đó là những người có thể sống còn.

Không phải tôi cố ý nói những lời này để hù dọa quý vị. Đã đến lúc tôi không thể không lên tiếng, thời đại này không phải là thời đại hòa bình, đây là một thời đại “Vô Cùng Nguy Ngập”''',
    },
    {
      'title': 'PHÁP KIẾT TƯỜNG (Trong Thần Chú Lăng Nghiêm)',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview':
          '''Pháp Kiết Tường: Tụng trì thần chú này thì tất cả sự việc đều tùy tâm như ý, thật kiết tường may mắn. Tôi sẽ giải thích rõ những pháp này cho quý vị.

Dẫu có giảng nhiều năm mà vẫn không thể giảng hết những điểm hay của thần chú này. Tất cả 10 phương chư Phật đều sanh xuất từ thần chú này, nên có thể gọi là thần chú Lăng Nghiêm là mẹ của chư Phật.''',
    },
    {
      'title': 'Cuộc Đời Và Đạo Nghiệp Của Hòa Thượng Phổ Quang',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview':
          '''Ngài sinh vào ngày 8 tháng 4 năm 1901 - là một trong những câu chuyện huyền thoại sống động nhất của Phật giáo đương đại. Ngài được xem là bậc cao tăng đại khổ hạnh ẩn tu tại núi Chung Nam, biểu tượng sống của sức mạnh Thần Chú Lăng Nghiêm và tinh hoa võ học Thiếu Lâm.

Dưới đây là tóm tắt những nội dung đắt giá nhất về cuộc đời và đạo nghiệp của Ngài:

1. Thân thế ly kỳ và phương pháp thọ giáo độc nhất

• Mồ côi từ nhỏ, bén duyên cửa Phật: Ngài sinh năm 1901, mới 8 tháng tuổi thì cha mẹ đều qua đời giữa thời loạn lạc. Ngài được một vị cao tăng đồng hương đưa về chùa Thiếu Lâm nuôi dưỡng và đặt pháp hiệu là Phổ Quang.

• Học kinh bằng "3 câu đổi 1 miếng cơm": Khi Ngài vừa biết nói, sư phụ đã dạy Ngài học thuộc Chú Lăng Nghiêm. Phương pháp dạy vô cùng nghiêm khắc: mỗi ngày học thuộc 3 câu chú mới được ăn một miếng cơm. Dù hoàn toàn không biết chữ văn tự, đến năm 15 tuổi Ngài đã thuộc lòng vô số kinh điển và thần chú Phật giáo, bất kể bắt đầu từ đoạn nào cũng đọc lại không sai một từ.

• Thành tựu 47 tuyệt kỹ Thiếu Lâm: Ngài được sư phụ truyền dạy trọn vẹn 47 môn tuyệt kỷ võ học Thiếu Lâm (Kim Cang Tráo, Thiết Bố Sam, Thiết Sa Chưởng, Đồng Tử Công...).

• Lời dặn ẩn tu trước tuổi 60: Năm 1927, trước khi viên tịch, sư phụ dặn Ngài trước 60 tuổi tuyệt đối không giao du với người thế tục để bảo toàn công phu và tránh bị kẻ ác tổn hại.

2. Hành trình ẩn tu thâm sơn và sự cảm hóa muôn loài

• Thuần hóa thú dữ tại núi Trường Bạch: Năm 22 tuổi, Ngài cùng sư đệ vào núi Trường Bạch khổ luyện. Tại đây, Ngài đã cảm hóa một con hổ dữ bằng cách chia sẻ thức ăn và cho hổ nằm bên cạnh nghe tụng 108 biến Chú Lăng Nghiêm mỗi ngày suốt 8 năm cho đến khi nó chết già. Nhiều loài tinh tinh, vượn trắng cũng quy y, biết quét cổng, hái trái cây và giúp Ngài thổi lửa.

• Khổ hạnh tại núi Chung Nam: Ngài chuyển sang núi Chung Nam (ở độ cao hơn 3.000m) – nơi nổi tiếng là địa linh ẩn tu của các bậc đắc đạo.

• Triết lý "Nhất thiết duy tâm": Những năm tháng đầu trên núi không có lương thực, Ngài ăn lá cây vào mùa hè và vỏ cây vào mùa đông giã thành bột pha nước lạnh. Ngài dạy: "Bạn nói nó là lá cây vỏ cây thì nó là lá cây vỏ cây, bạn nói nó là bột mì thì nó chính là bột mì".

3. Tự tay xây dựng Quan Âm Cổ Động bằng một chiếc cuốc

• Đục 5.000 bậc thang đá: Nhận thấy Quan Âm Cổ Động là nơi từ trường tâm linh tối ưu nhưng không có đường lên, Ngài đã tự tay đục đẽo hơn 5.000 bậc thang đá băng qua vách núi hiểm trở.

• Dựng chùa làm chỗ tựa cho hậu thế: Dù chỉ có một chiếc cuốc và đôi tay trần, Ngài đã san phẳng vách núi, tự xẻ đá đập gạch xây nên Đại Hùng Bảo Điện, Viên Thông Điện cùng hơn 60 gian nhà đá để làm đạo tràng cho người tu hành tương lai. Ngài còn tự bỏ tiền mua màu về nhắm mắt quán tưởng để vẽ 32 bức tượng Bồ Tát Quán Thế Âm lên tường đất.

4. Kỷ lục trì tụng Chú Lăng Nghiêm và những hiện tượng kỳ diệu

• Kỷ lục 5,6 triệu biến Lăng Nghiêm: Ngài dành trọn hơn 100 năm cuộc đời chuyên trì Thần Chú Lăng Nghiêm. Trung bình mỗi ngày Ngài tụng 108 biến (hoặc 210 biến mỗi 10 ngày), tổng cộng đã tích lũy hơn 5,6 triệu biến – một con số kỷ lục trong lịch sử Phật giáo.

• Thân thể kim cương bất hoại kỳ diệu:

  • Diện mạo trẻ thơ: Ở tuổi 120+, da dẻ Ngài vẫn hồng hào, mắt sáng tai tường, giọng nói vang dội như chuông. Răng của Ngài đã rụng và mọc mới lại 3 lần, sở hữu 36 chiếc răng trắng đều.

  • Tự tỏa hương chiên đàn: Dù hầu như không tắm rửa hay thay giặt thường xuyên, thân thể và quần áo Ngài luôn tỏa ra mùi hương hoa đàn thanh nhã. Chuỗi hạt được Ngài cầm xoa qua lập tức đượm mùi đàn hương ngạt ngào.

  • Cơ bắp như đồng sắt: Dù chỉ ăn bắp cải, đậu phụ và muối, cơ bắp Ngài vẫn cứng chắc như đá. Đêm đến, hầu như Ngài không ngủ, Ngài vừa đi vừa trì tụng 108 biến Lăng Nghiêm''',
    },
    // --- KHAI THỊ CŨ ---
    {
      'title': 'Cột Mốc 36.000 Biến & Đài Sen Nâng Đỡ',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview':
          'Khi một hành giả chí tâm trì tụng đạt tới cột mốc tối thượng 36.000 biến, những phép mầu hiện tiền sẽ hóa sinh. Tích lũy đủ 36.000 lần một cách chuẩn xác, một hiện tượng vi diệu sẽ xuất hiện: dưới thân người đó sẽ hiện ra một đài sen nâng đỡ trong khoảng không vô hình.',
    },
    {
      'title': 'Định Quốc Vãng Sinh — 36.000 Đạo Hào Quang',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview':
          'Mỗi biến Chú Lăng Nghiêm được tụng lên giống như việc vẽ một đạo hào quang rực rỡ bao bọc xung quanh cơ thể. Do đó, khi tụng đủ 36.000 biến, thân tâm hành giả sẽ có 36.000 đạo hào quang kiên cố bảo vệ, chắc chắn thoát khỏi ba đường ác nghiệp.',
    },
    {
      'title': 'Cứu Độ Cha Mẹ Trong Bảy Đời Nhiều Kiếp',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview':
          'Năng lực của 36.000 biến tụng không chỉ đem lại sự thành tựu riêng cho bản thân, mà còn tỏa năng lượng cứu độ to lớn. Công đức thù thắng này có thể giúp cứu độ cha mẹ trong bảy đời, thậm chí là cha mẹ trong nhiều kiếp quá khứ đều được giải thoát siêu sinh.',
    },
    {
      'title': 'Sự Tồn Vong Của Chánh Pháp',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview':
          'Chú Lăng Nghiêm là linh văn cứu mạng của trời đất. Bất cứ lúc nào cũng phải có người trì tụng Chú Lăng Nghiêm để chống đỡ trời đất, không để cho thế giới đi đến chỗ hoại diệt. Nếu không còn ai tụng Chú Lăng Nghiêm nữa, thế giới này sẽ nhanh chóng đi đến cõi diệt.',
    },
    {
      'title': 'Cảnh Giới Thân Kim Cang Bất Hoại',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview':
          'Quá trình tinh tấn trì tụng đại thần chú giúp trược khí giảm sâu, thanh khí thăng tiến, chuyển hóa phàm thân thành Thân Kim Cang. Cơ thể trở nên cứng chắc như đồng sắt, hàm răng 36 chiếc tự mọc lại, và thân thể tự tỏa mùi hương đàn hương nồng nàn bất biến.',
    },
    {
      'title': 'Bách Độc Bất Sâm & Thần Thông Muông Thú',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview':
          'Thân thể miễn nhiễm hoàn toàn với tất cả bệnh tật, độc chất. Đặc biệt, khi hành giả trì tụng vượt qua mốc 1.000.000 biến, họ sẽ đắc được khả năng thấu hiểu ngôn ngữ của muôn loài động vật, thoát khỏi thế giới hư ảo huyễn cảnh.',
    },
    {
      'title': 'Vì Sao Trì Lăng Nghiêm Chú Phải Niệm Lớn Tiếng',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview':
          'Phàm là người đến Quan Âm Cổ Động tu hành thì nhất định phải niệm lớn tiếng. Vì sao thầy kêu các Phật tử niệm lớn tiếng? Niệm lớn tiếng Lăng Nghiêm Chú, thì hoa sen của các Phật tử cũng lớn theo. Niệm cho tốt thì cha mẹ đều được lợi ích, đều được ngồi trên hoa sen. Các Phật tử xem Thích Ca Mâu Ni Phật, Dược Sư Phật, A Di Đà Phật trong Đại Hùng Bảo Điện, các Ngài đều ngồi trên hoa sen 5 tầng.\n\nNiệm lớn tiếng Lăng Nghiêm Chú không chỉ có lợi cho bản thân. Nó còn có thể đả thông toàn bộ kinh mạch trong thân thể. Niệm lớn tiếng thì sẽ không còn đủ thứ vọng tưởng nữa.\n\nVì sao cả đời thầy không cho phép mặc niệm và niệm nhỏ tiếng? Niệm Lăng Nghiêm Chú phải hét to ra, âm thanh càng lớn càng tốt. Thầy thích nhất là người có âm thanh lớn. Khi hét to ra rồi, thì thân và tâm của Phật tử đều ở trong câu chú, sẽ không đi khởi vọng tưởng nữa. Đủ thứ bệnh tật cũng không còn. Cũng sẽ không có 50 loại ấm ma. Ấm ma là gì? Chính là tà tư tà kiến trong tâm của chính mình, như vậy là bị ma ám rồi.\n\nNiệm lớn tiếng Lăng Nghiêm Chú, hết thảy ma đều không còn. Chúng nó từ xa đều quỳ xuống dập đầu đảnh lễ Phật tử. Cho đến những con trùng con kiến, tất cả chúng sinh, chỉ cần nghe được thôi, vị lai đều sẽ thành Phật.\n\nMỗi một chữ mỗi một câu của Lăng Nghiêm Chú đều là phá địa ngục. Những chúng sinh đang chịu khổ trong địa ngục đều có thể được độ. Cho nên uy lực của Lăng Nghiêm Chú chính là lớn như vậy đó.',
    },
    {
      'title': 'Cấu Trúc Khởi Đầu Của Bài Tụng',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview':
          'Để bài trì chú có hiệu quả tốt nhất, tuyệt đối không nên bỏ qua nghi thức khởi đầu: Luôn phải niệm 3 lần câu "Đại Phật Đảnh Thủ Lăng Nghiêm Thần Chú". Câu này giống như cái đầu, phần thần chú là thân thể; nếu không tụng giống như cơ thể không có đầu.',
    },
    {
      'title': 'Sự Bảo Vệ Của 8 Vạn 4 Ngàn Kim Cang Tạng',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview':
          'Bạn tụng Chú Lăng Nghiêm, dù bạn chỉ tụng một chữ, một câu, một hội, hay toàn bộ, thì tám vạn bốn ngàn Kim Cang Tạng Bồ Tát cùng quyến thuộc của các ngài cũng luôn luôn theo bảo vệ bạn cẩn thận, không để cho bất kỳ loài ma quỷ nào đến quấy nhiễu.',
    },
    {
      'title': 'Không Nên Ăn Trứng Khi Trì Chú',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview':
          'Không nên ăn trứng khi trì tụng Chú Lăng Nghiêm. Việc ăn trứng gà mang tội nặng hơn cả ăn thịt thông thường, bởi lẽ mỗi quả trứng đại diện cho một sinh mạng nguyên vẹn. Ăn trứng mang mùi tanh, ngăn cản thân tâm đạt đến thuần tịnh Lăng Nghiêm Tam Muội.',
    },
    {
      'title': 'Bảo Pháp Ngũ Đại Tâm Chú Cho Người Bận Rộn',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview':
          'Nếu không đủ thời gian trì toàn bộ, hãy tụng Ngũ Đại Tâm Chú: SẤT ĐÀN NỂ — A CA GIA — MẬT RỊ TRỤ — BÁT RỊ ĐÁT RA GIA — NẢNH YẾT RỊ. Chỉ cần trì 7 biến hằng ngày, công đức tạo ra còn to lớn hơn cả việc trì tụng đủ 108 biến Chú Đại Bi tinh tấn.',
    },
    {
      'title': 'Hàng Phục Ma Quân',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview':
          'Chú Lăng Nghiêm là thần chú uy lực nhất để hàng phục ma oán. Khi bạn tụng Chú Lăng Nghiêm, tất cả tà ma ngoại đạo, yêu ma quỷ quái đều khiếp sợ và không dám đến gần. Đó là vì Chú Lăng Nghiêm phát ra hào quang rực rỡ của Phật, soi sáng khắp pháp giới.',
    },

    // --- KHAI THỊ MỚI (NGUYÊN VĂN) ---
    {
      'title': 'Vụ Trứng Gà',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview':
          '“Bạn cho rằng ăn chay thì ăn trứng cũng được? Cũng được! Chờ tới khi bạn đầu thai làm gà rồi khi đó bạn sẽ hiểu (phận làm gà) chính do ăn trứng gà mà ra”.\n\nHỏi: Là đệ tử Phật thì có thể ăn trứng không?\nĐáp: Nếu quý vị thèm muốn ăn những thứ dinh dưỡng đó, thì cần gì phải hỏi tôi?\n\nHỏi: Tại sao người ăn chay không được ăn trứng?\nĐáp: Không có gà trống, gà mái cũng có thể ấp trứng nở ra gà con như thường. Ngày xưa người ta không hiểu điều này nên họ nói là, nếu trứng không có trống thì không thể nở ra gà con. Nhưng lối nói này cũng không đúng sự thật. Bởi vì đạo lý vốn không có tuyệt đối, cho nên chúng ta ăn chay quyết không nên ăn trứng.\n\nHỏi: Lúc ăn chay có thể ăn trứng gà không?\nĐáp: Bạn chưa ăn đã muốn biết! Cùng với không ăn thì thế nào? Ăn thì thế nào?',
    },
    {
      'title': 'Sự Bảo Vệ Của Ngàn Đóa Hoa Sen',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview':
          'Hai mươi chín câu Chú đầu tiên, một khi niệm ra thì sẽ xuất hiện một cảnh giới là: bốn mặt tám phương có rất nhiều hoa sen đỏ đến ủng hộ người trì Chú này, cho nên nói: "Ngàn đóa sen đỏ hộ người trì." (Thiên đóa hồng liên hộ trụ thân). Tám vạn bốn ngàn Kim Cang tạng Bồ tát cũng đến gia hộ bạn, cho nên nói: "Ngồi trên hoa sen đi mây trắng" (Tọa liên phi thừa bạch vân đôn). Câu Chú này (Nam Mô Tát Đát Tha) vốn dĩ bảo hộ người tụng, ai mà trì câu Chú này thì Ma vương Ba Tuần không có cách gì lại gần được.',
    },
    {
      'title': 'Tại Sao Người Ta Muốn Tự Sát?',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview':
          'Tôi nói cho quý vị biết, những người tự sát đa số đều bị ma quỷ kêu họ đến đó. Con quỷ đó đối với người tự sát đã niệm một bài chú. Quỷ niệm chú gì? Nó nói: “Mày đi chết đi! Mày đi chết đi! Chết đi là tốt lắm! Chết đi là tốt nhất đó!”. Con quỷ đó có tha tâm thông, nó lấy quỷ khí xâm nhập vào tâm của người đó khiến người đó nghĩ rằng: “A! Chết đi là tốt! Chết đi là tốt!”. Thế là người đó bèn đi uống thuốc độc tự tử, treo cổ, nhảy xuống biển... Vì vậy bất cứ lúc nào, mọi người cần phải niệm Phật, niệm chú. Quý vị niệm Phật niệm chú thì lúc đó có Phật quang phổ chiếu, ma quỷ sẽ bỏ chạy đi mất.',
    },
    {
      'title': 'Bồ Tát Kim Cang Tạng Âm Thầm Thúc Giục',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview':
          'Giả sử tâm niệm của quý vị vô cùng tán loạn, không thể chuyên nhất, nhưng nếu miệng của quý vị liền trì tụng Chú Lăng Nghiêm, thì Bồ Tát Kim Cang Tạng Vương liền dùng tâm tinh chân thuần thục đi theo âm thầm thúc giục. Chữ “âm thầm thúc giục” này vô cùng quan trọng, có nghĩa là ở phía sau âm thầm đẩy bạn một cái, âm thầm hướng dẫn bạn, nhắc nhở bạn. Khiến tâm tán loạn của quý vị dần mất đi, một chút, một chút một sinh ra định lực, rồi đạt được định lực, dần dần quý vị sẽ được khai mở trí huệ.',
    },
    {
      'title': 'Trì Chú Lăng Nghiêm Nhất Tâm',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview':
          'Khi tụng Chú Lăng Nghiêm không nên có tâm mong cầu, không mong cầu đắc thần thông, không mong cầu đắc Phật nhãn, không mong cầu tiêu tai, không mong cầu khỏi bệnh... Chỉ cần nhất tâm tụng trì, thì công đức mới lớn. Giống như đứa trẻ bú mẹ, chỉ biết bú thôi chứ đâu có nghĩ gì khác. Bú no rồi thì ngủ, ngủ dậy lại bú. Người tụng chú cũng phải như thế, không được có một vọng niệm nào xen vào.',
    },
    {
      'title': 'Không Ăn Ngũ Vị Tân',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview':
          'Đức Phật dạy trong Kinh Lăng Nghiêm: Các chúng sinh cầu quả Bồ Đề, cốt yếu là không được ăn ngũ vị tân (hành, tỏi, nén, hẹ, hưng hào). Vì năm thứ vị cay này, ăn chín thì phát dâm, ăn sống thì thêm phẫn nộ. Những người ăn năm thứ vị cay này, tuy có tụng trì mười hai bộ kinh Phật, mười phương Thiên tiên cũng đều chê mùi hôi thối mà tránh xa. Các ngạ quỷ sẽ thường liếm môi miệng của người ấy, do luôn sống chung với quỷ nên phước đức ngày càng tiêu mòn, chẳng lợi ích gì.',
    },
    {
      'title': 'Cảnh Giới Nhiệm Màu',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview':
          'Khi niệm câu "Nam Mô Lăng Nghiêm Hội Thượng Phật Bồ Tát" đủ ba lần, trên hư không bỗng hiện ra một Đàn thành Lăng Nghiêm rộng lớn đến mức không thấy biên giới. Đàn thành ấy như một cái ô khổng lồ bằng ánh sáng bao phủ từ trên không trung xuống. Bên trong Đàn thành có vô số chư Phật, chư Đại Bồ Tát cùng tám vạn bốn ngàn Kim Cang Tạng Bồ Tát. Tất cả các Ngài đều phóng ra đủ thứ hào quang vô cùng rực rỡ và vi diệu, chiếu rọi khắp nơi và gia trì cho tất cả mọi người. Sự hiện diện và ánh sáng từ Đàn thành không chỉ bảo vệ mà còn đem lại lợi ích lớn lao cho những ai thành tâm trì tụng, giúp họ tiêu trừ nghiệp chướng, tâm trí thanh tịnh và ngày càng tinh tấn trên con đường tu hành.',
    },
    {
      'title': 'Tâm Của Phật - Thân Của Phật',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview':
          'Bạch ân sư Phổ Quang! Thần Chú Lăng Nghiêm tại sao lại có sức mạnh lớn như vậy ạ?\nHT. Phổ Quang: Thần Chú Lăng Nghiêm này là pháp môn thù thắng nhất trong các pháp môn. Bởi vì nó chính là tâm của Phật, là thân của Phật. Không có thần Chú Lăng Nghiêm, thì không có tất cả chư Phật! ... Con người nếu thật sự hiểu được điều này, thì đã không còn là phàm phu nữa rồi! Niệm đủ 36.000 biến, dưới hai bàn chân của con cũng có hoa sen, khi con đi đứng, thực ra là có hoa sen nâng đỡ, chỉ là nhục nhãn của con nhìn không thấy mà thôi.',
    },
    {
      'title': 'Cảnh Giới Đại Tự Tại',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview':
          'Có câu: "Làm người thì hiếm khi khờ khạo", nhưng tu hành thì phải đảo ngược lại! Tu hành là phải học cách khờ khạo... Nếu như bạn chẳng có trí tuệ, bạn sẽ chẳng thể khờ khạo được. Giống như Bồ Tát Bố Đại vậy, Ngài khờ nhưng mà Ngài lại sống rất sung sướng! Sống trên đời đừng bao giờ dằn vặt người khác, cũng đừng dằn vặt chính mình! Chuyện lúc tám giờ thì đến chín giờ là phải quên đi rồi. Để những chuyện phiền não đó trong lòng làm chi? Việc gì đã qua thì cứ để nó qua đi! Đó mới là Phật, Bồ-tát, đó mới là khai đại ngộ! Cho nên phải niệm Chú Lăng Nghiêm, niệm Chú Lăng Nghiêm mới có thể có định lực, mới có thể khai mở trí tuệ, một đời thành Phật đạo.',
    },
    {
      'title': 'Công Đức Bằng 10 Toa Tàu Hỏa Kinh Đại Tạng',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview':
          'Kinh Đại Tạng nhiều như vậy, niệm tới bao giờ mới hết? Nhưng niệm một biến chú Lăng Nghiêm thì công đức bằng cả niệm 10 toa tàu hỏa đầy ắp kinh Đại Tạng! Ai muốn tụng hết bộ kinh Đại Tạng thì thà niệm một biến chú Lăng Nghiêm còn hơn. Có người tu thiền, có người niệm Phật, có người trì chú... có tới 8 vạn 4 ngàn pháp môn, nhưng cho dù có tu pháp nào đi nữa, cũng chẳng bằng chuyên tâm tu một mình chú Lăng Nghiêm. Cho nên, ai tu được chú Lăng Nghiêm, người đó thật sự là có đại phúc báo!',
    },
    {
      'title': 'Siêu Độ Cho Người Đã Khuất',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview':
          'Có người hỏi về cách siêu độ cho người thân đã khuất. Hòa thượng Phổ Quang đáp: Khi vừa niệm chú, bạn phải vừa quán tưởng lại gương mặt với ngũ quan đang mỉm cười lúc sinh tiền của người chết. Cứ nhất tâm niệm như vậy thì dưới chân thần thức của người mất sẽ lập tức hiện ra một đóa hoa sen, người mất tự nhiên sẽ nhận được lợi ích siêu thoát.',
    },
    {
      'title': 'Niệm Lăng Nghiêm Chú Như Đi Thang Máy',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview':
          'Mọi người cùng nhau niệm Lăng Nghiêm Chú thì thế giới sẽ bình yên, đất nước sẽ tai qua nạn khỏi.\n\nMỗi bộ kinh chia ra rất nhiều phần. Đọc cả đời cũng không hết. Nhưng Lăng Nghiêm Chú đã bao gồm hết tất cả kinh điển rồi. Kinh Tâm Kinh chính là phần tinh túy nhất của tất cả kinh. Là để cho mình hiểu và ngộ ra.\n\nNiệm A Di Đà Phật thì thoát được sinh tử, nhưng phải thật nhất tâm, tâm phải thật sạch. Tham, sân, si, kiêu mạn, nghi ngờ... mỗi chữ là một cảnh. Sẽ đọa vào đường A Tu La, đường ngạ quỷ... rơi vào đường nào thì theo đường đó.\n\nNiệm Đại Bi Chú 108 lần cũng không bằng niệm 1 lần Lăng Nghiêm Chú. Không bằng niệm 7 lần Ngũ Đại Tâm Chú. Đại Bi Chú là để cứu khổ. Niệm đến mức cao nhất thì toàn thân sáng lên, có thể thành Bồ Tát, nhưng vẫn chưa thành Phật được. Muốn thành Phật thì phải niệm Lăng Nghiêm Chú này.\n\nNiệm kinh khác thì phải hồi hướng. Nhưng niệm Lăng Nghiêm Chú này và Kinh Kim Cang thì không cần hồi hướng. Đức Phật đã ấn chứng rồi. Không cần phải làm thêm nữa. Niệm Lăng Nghiêm Chú, một đời này là thành Phật.\n\nNiệm Lăng Nghiêm Chú giống như đi thang máy vậy đó. VÈO một cái là thành Phật rồi!',
    },
    {
      'title': 'Động Từ Bi',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview':
          'Động Từ Bi, từ xưa đến nay không biết đã có bao nhiêu vị đại đức (bậc tu hành cao thâm) đến đây đóng cửa ẩn tu rồi. Sư phụ là hòa thượng Phổ Quang kể lại rằng, những giọt nước rỉ ra từ khe đá trong động chính là nước mắt của Phật Bồ Tát. Nước này có thể uống chứ không được lãng phí, và còn chữa được bách bệnh. Căn nhà đá nhỏ nhắn, giản dị kia chính là nơi hòa thượng Phổ Quang từng tu hành lúc còn trẻ. Thời Dân Quốc, các vị hòa thượng nổi tiếng như ngài Hư Vân, pháp sư Viên Anh, và hòa thượng Lai Quả cũng đều từng tu hành ở nơi này.',
    },

    // --- KHAI THỊ BỔ SUNG (GIỮ NGUYÊN NỘI DUNG GỐC) ---
    {
      'title': 'THẦN CHÚ KHAI MỞ TRÍ TUỆ',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview':
          '''Vấn đáp cùng Hoà Thượng Tuyên Hoá vào ngày 10 tháng 01 năm 1993

tại Học Viện Công Nghiệp Kỹ Thuật Quốc Lập - Đài Loan

Phiên dịch bởi Viện Dịch Kinh Quốc Tế

https://www.drbachinese.org/vbs/publish/453/vbs453p020.pdf

Hỏi: Con là một đệ tử, và con rất thích đọc những sách của Hòa Thượng. Con có một câu hỏi quan trọng như sau. Hòa Thượng đã đề cập rằng có hai câu chú trong Chú Lăng Nghiêm có thể khai mở trí tuệ cho chúng ta. Xin Hoà Thượng hãy nói cho chúng con biết đó là hai câu chú nào? Tạ ơn sự từ bi chỉ dẫn của ngài. Nam Mô Đại Từ Đại Bi Quán Thế Âm Bồ Tát.

Đáp: Đúng vậy, ta có thể nói cho quý vị, nhưng tin hay không tin là tùy quý vị. Ta cũng không thể tùy tiện nói cho quý vị nghe. Trước hết quý vị hãy cho ta biết là quý vị có thành thật niệm hay không? Nếu ta nói cho quý vị nghe, rồi quý vị cũng quên mất, đồng thời cũng không tụng niệm. Qua một thời gian, quý vị lại hỏi: “Xin Sư Phụ nói cho con biết hai câu chú này, cho đến bây giờ con vẫn chưa khai trí tuệ.” Tại sao trí tuệ của quý vị chưa khai mở? Là do quý vị không tụng niệm, vậy thì làm sao trí tuệ của quý vị có thể khai mở được? Do đó, nếu quý vị muốn học hai câu Thần chú này, thì nhất định phải nhất tâm dụng công tụng niệm, thậm chí không ăn cũng được nhưng không thể không niệm Thần chú này, thậm chí không mặc đồ cũng được nhưng không thể không niệm Thần chú này, thậm chí không ngủ cũng được nhưng không thể không niệm Thần chú này. Nếu quý vị có quyết tâm như vậy, thì trí tuệ của quý vị chắc chắn sẽ khai mở. Nếu quý vị không có được quyết tâm như vậy mà chỉ muốn tìm cơ hội đi đường tắt, mong ta chỉ giáo vài câu, rồi nghĩ rằng như thế là có được bảo bối, thì rốt cuộc quý vị cũng chẳng được gì cả.

Bây giờ thì ta có thể giải thích một chút. Hai câu chú này là:

“Thỉnh cầu chư Phật và chư vị Bồ Tát khai mở trí tuệ, khai mở trí tuệ chân chánh, không phải trí tuệ thế gian. Khiến con có thể nhận thức rõ tất cả các Pháp và phi Pháp. Có được Trạch Pháp Nhãn (mắt chọn Pháp).”

Chú này được nói ra bởi Hoá Phật trên đảnh đầu (Vô Kiến Đảnh Tướng) của Phật Thích Ca Mâu Ni. Bởi vậy mỗi câu chú này đều là những linh văn, đều là chân ngôn diệu ngữ, do đó hai câu chú này nói rằng, “Thỉnh chư Phật và chư vị Bồ Tát, xin hãy gia hộ cho con, khiến con được khai mở đại trí tuệ.”

Ý nghĩa của Thần chú này cũng gọi là “chân ngôn”, cũng gọi là “linh văn”.

Tại sao gọi là “chân ngôn”? Bởi vì Thần chú này không có một chút giả dối nào cả.

Tại sao gọi là “linh văn”? Bởi vì Thần chú này vốn là của trời Phạm Thiên và được Đức Phật Thích Ca Mâu Ni dùng chú này để giải cứu ngài A-nan. Do đó một số người không biết cách để sử dụng Thần chú này. Ta lại nói thêm cho quý vị nghe rằng từ lúc ta còn nhỏ, ta đã đi khắp nơi hàng phục yêu ma và bắt quỷ quái. Những loài yêu ma quỷ quái có thể biến hóa thành người. ta đã gặp hơn một trăm loại này. Chúng đi đâu là hại người đến đó, vì thế ta đã dùng Chú Lăng Nghiêm để hàng phục chúng. Kết cuộc là tất cả yêu ma quỷ quái đều muốn cùng ta nhất quyết tử chiến, vì vậy phiền phức lại kéo đến, gây ra rất nhiều rắc rối. Do nhân duyên đó, nay tuổi ta đã lớn, có lẽ cũng đã từng trải, nên không còn muốn tranh đấu với chúng.

Nhân vì:

Tranh là phân thắng bại,

Đi ngược lại với Đạo.

Trong Tâm sanh bốn tướng,

Làm sao vào Tam Muội (Định)? (1)

Tam Muội, chính là Chánh Định, Chánh Thọ. Khi chúng ta cùng người tranh chấp, tức là có tâm hơn thua: hoặc ta thắng người thua, hoặc ta thua người thắng. Tâm tranh thắng bại ấy chính là “Đi ngược lại với Đạo”. Vì ngược lại với Đạo, tâm sanh khởi bốn tướng: ngã tướng, nhân tướng, chúng sanh tướng, thọ giả tướng.

Khi bốn tướng hiện tiền, làm sao có được định lực? Làm sao có thể chứng đắc Chánh Định, Chánh Thọ?

Cho nên, bất luận việc gì, chúng ta cũng không nên dùng bạo lực để giải quyết vấn đề, mà cần phải giải quyết trong tinh thần hòa bình. Không nên trên dưới cùng nhau tranh lợi, mà chúng ta cần phải dùng hòa khí, từ bi để đối đãi.

Nếu một quốc gia, mọi người đều hòa thuận, có hòa khí, thì quốc gia ấy nhất định sẽ hưng thịnh. Còn nếu suốt ngày tranh đấu, kẻ này giành của kẻ kia, người này đánh mắng người kia, thì thật chẳng tốt đẹp, chẳng cát tường chút nào cả.

Ghi chú:

Nguyên văn Hoa ngữ:

(1)

爭是勝負心，

與道相違背，

便生四相心,

由何得三昧？

Tranh thị thắng phụ tâm,

Dữ đạo tương vi bối，

Tiện sanh tứ tương tâm，

Do hà đắc tam muội？''',
    },
    {
      'title':
          'THẬT SỰ CÓ THỂ TRÌ CHÚ LĂNG NGHIÊM, TRONG HƯ KHÔNG LIỀN CÓ MỘT ĐẠI BẠCH TÁN CÁI, CÓ OAI THẦN LỰC “PHỔ ẤM MUÔN PHƯƠNG”!',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview': '''Tuyên Công Thượng Nhân khai thị

“Thiên tán cái vân”: “Thiên tán cái vân” nghĩa là hương mà bạn đốt kết tụ giữa hư không, hình thành một cái lọng giống như chiếc dù, che phủ và bảo hộ chúng sinh. Trong Chú Lăng Nghiêm có Đại Bạch Tán Cái. Khi bạn tụng chú này, trong hư không liền hiện ra một Đại Bạch Tán Cái. Nơi được Đại Bạch Tán Cái che phủ thì không có các loại tai nạn, không có động đất, không có thiên tai, tất cả tai nạn đều không xảy đến!

Chữ “Cái” trong câu “chấp trì nhất cái”, theo Mật tông, chính là chỉ Đại Bạch Tán Cái trong Chú Lăng Nghiêm. Trong Chú Lăng Nghiêm có chú tâm — “悉怛多鉢怛囉” (Tất Đát Đa Bát Đát La). Sáu chữ này chính là chú tâm. Nếu nhất tâm chuyên chú, tâm không tạp niệm, chí thành trì tụng thì trong hư không có thể hiện ra một Đại Bạch Tán Cái. Đại Bạch Tán Cái ấy có oai thần lực “phổ ấm muôn phương”, tức che chở khắp mọi phương.

Phàm nơi nào được nó che phủ thì đao binh không khởi, ôn dịch không sinh, nước lửa và trộm cướp đều dứt sạch; chỉ có như ý cát tường, mưa thuận gió hòa, nhân dân an lạc, không có bất kỳ tai nạn nào.

Nếu nói theo giáo pháp, chữ “cái” này chính là diệu pháp của thật tướng. Thật tướng không có tướng, nhưng lại không gì chẳng phải tướng. Từ thật tướng mà sinh ra tất cả các pháp, dùng tất cả các pháp để giáo hóa chúng sinh trong chín pháp giới. Đây chính là đạo lý:

“Một gốc phân tán thành muôn hình vạn trạng, muôn hình vạn trạng cuối cùng vẫn quy về một gốc.”

Trì tụng câu chú tâm này thì trên đỉnh đầu sẽ có các loại bảo cái hộ trì bạn.

“悉怛多鉢怛囉” (Tất Đát Đa Bát Đát La) là chú tâm của Chú Lăng Nghiêm, cho nên có người thường xuyên trì tụng câu chú này. Trì tụng câu chú này thì có các loại bảo cái; trong đó chủ yếu là dựng nên Đại Bạch Tán Cái.

Chúng ta mỗi ngày có thể trì tụng Chú Lăng Nghiêm, chính là đang giúp đỡ toàn thế giới, khiến tai nạn trên toàn thế giới có thể giảm bớt một phần, nghiệp ma cũng giảm bớt một phần. Vì vậy, Chú Lăng Nghiêm vô cùng quan trọng!

Bảo cái có rất nhiều loại, cho nên nói là các loại bảo cái; lại có các loại mây hương, mây hoa, chứ không phải chỉ có một loại. Những bảo cái, mây hương và mây hoa này thường ở trên đỉnh đầu bạn để hộ trì bạn. Vì thế, rất nhiều việc vốn có vấn đề cũng trở thành không có vấn đề; dù có chuyện bất ngờ cũng không xảy ra tai nạn. Đây là sự lợi ích đối với tất cả mọi người trên thế giới.

Vì vậy, chúng ta trì tụng Chú Lăng Nghiêm chính là đang giúp đỡ thế giới, khiến thế giới giảm bớt những tai nạn như tai nạn hàng không, tai nạn giao thông. Chẳng hạn như tai nạn tàu hỏa, tai nạn ô tô, tai nạn máy bay, xe buýt, thậm chí cả chiến tranh, đạn pháo — những tai nạn ấy đều có thể được âm thầm hóa giải. Đồng thời cũng tiêu trừ tai chướng của chúng sinh. Khi tai chướng không còn, con người liền được bình an. Đây chính là lợi ích cho quần chúng.

Bạn có thể mỗi ngày một giây cũng không gián đoạn trì tụng Chú Lăng Nghiêm, nhất định sẽ có đại cảm ứng. Chỉ cần không gián đoạn; không gián đoạn chính là Tam-muội.

Chư Phật có năm bộ:

Phương Đông: Kim Cang Bộ

Phương Nam: Bảo Sinh Bộ

Phương Tây: Liên Hoa Bộ

Phương Bắc: Yết Ma Bộ

Trung ương: Phật Bộ

“悉怛多鉢怛囉” (Tất Đát Đa Bát Đát La) là pháp của Phật Bộ Trung ương, cho nên có thể nhiếp phục năm đại ma quân.

Nếu không có chư Phật năm phương, năm đại ma quân sẽ ngày ngày tung hoành trên thế giới — chúng ngang dọc không kiêng nể, không chút e dè. May thay có chư Phật ở năm phương âm thầm trấn phục chúng, nên chúng không dám công khai hoành hành.

Bất luận là loại yêu ma quỷ quái nào, thiên ma hay ngoại đạo, tất cả đều phải thuận theo sức mạnh của Chú Lăng Nghiêm. Nếu không thuận theo thì sẽ bị tiêu diệt. Chú Lăng Nghiêm có pháp lực tiêu diệt và phá tan tất cả ma quân.

Vì vậy, người biết trì tụng Chú Lăng Nghiêm, thiên ma ngoại đạo và tất cả quỷ quái đều sợ bạn. Nếu chúng không sợ, cuối cùng chúng vẫn sẽ bị hàng phục dưới sức mạnh của bạn.''',
    },
    {
      'title': 'BUÔNG VÕ CÔNG, VÀO CHUNG NAM SƠN ĂN LÁ CÂY 72 NĂM',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': '''1. VÌ SAO KHÔNG LUYỆN VÕ NỮA?
Về sau, Lão Hòa Thượng nhận ra:
"Võ công có cao đến mấy cũng không thành đạo được, mà còn dễ làm tổn thương người.
Nhìn thấy chuyện bất bình là muốn xen vào.
Kết quả là để cứu 1 người tốt, có thể phải làm tổn thương 100 người xấu.
Oan oan tương báo đến bao giờ mới dứt?"

Ngài quyết định không luyện nữa.
Ngài nói: "Người đến 30 tuổi mà còn luyện võ công là chấp mê bất ngộ.
Công phu phải luyện từ nhỏ. Võ công có cao đến mấy cũng không thoát được sinh tử."

Từ đó Ngài trốn vào rừng sâu. Không tiếp xúc với ai.
Chuyện bất bình không nhìn thấy, cũng không có cơ hội "gây sự" nữa.

2. ĐI BỘ MẤY THÁNG ĐẾN CHUNG NAM SƠN
Về sau nghe nói Chung Nam Sơn là thánh địa mà bao đời hiền nhân ẩn sĩ tu hành đắc đạo.
Ngài liền dẫn đệ tử đi. Đi bộ mấy tháng mới tới.

Lúc đó cọp mù đã chết, tinh vẫn còn sống.
Thấy Ngài thu dọn y và thiền trượng định đi, nó ôm chân Ngài khóc, không cho đi.
Lão Hòa Thượng đành nhân lúc tinh ngủ, cầm thiền trượng và y, lén rời đi.

3. 72 NĂM ĂN LÁ CÂY VỎ CÂY
Chung Nam Sơn khác với Trường Bạch Sơn.
Không có cây ăn quả, đất lại xấu.
2 thầy trò không có quả rừng để ăn, cũng không thể trồng khoai như ở Trường Bạch để đỡ đói.

Nhưng Ngài vẫn nhớ lời Tổ dạy: không tiếp xúc với người.
Ngày ngày ngồi trong hang trì chú tu hành.
Hè ăn lá cây, đông ăn vỏ cây. Ăn như vậy 72 năm.
Ăn đủ 72 loại lá cây và vỏ cây.

Mãi đến cuối năm 1996 mới có cư sĩ Bắc Kinh lên núi gửi gạo.

Lúc đó dân rất nghèo. Nông dân làm quần quật cả ngày mới kiếm được 2 xu.
Lương thực cũng ít. Lão Hòa Thượng không bao giờ đến nhà dân "hóa duyên".
Lá cây khô đốt thành tro, hòa với nước lạnh uống cho no bụng.

Ngài nói: "72 loại cây đều ăn được. Chỉ cần giã lá và thân cây thành bột, nấu chín là ăn được. Rất bổ."
Ngài nói: "Tất cả do tâm tạo. Con nói nó là lá cây vỏ cây thì nó là lá cây vỏ cây. Con nói nó là bánh mì thì nó là bánh mì."
"Chỉ cần bụng không kêu ục ục, ruột không dính vào nhau, ngồi thiền được là được rồi."''',
    },
    {
      'title': 'Trì Chú Cần Chí Thành Chuyên Nhất',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': '''Phổ Quang Lão Hòa Thượng
Trích từ "Chung Nam Sơn Quan Âm Cổ Động Khai Thị Lục"

Chuyện trì chú , quan trọng nhất chính là 4 chữ 『Chí Thành Chuyên Nhất』!

Các Phật tử thấy không, Thầy hơn 100 tuổi rồi mà mỗi ngày vẫn thành thật niệm chú. Vì sao? Vì thầy biết chú này linh nghiệm lắm.

Thế nào là Chí Thành Chuyên Nhất? Thầy nói cho các Phật tử nghe:
Thứ nhất - Tâm phải thành, đừng có lăng xăng.
Miệng thì niệm chú mà tâm lại nghĩ chuyện khác, gọi là 『miệng niệm tâm không theo』, vậy thì vô ích!

Thứ hai - Phải chuyên nhất một môn.
Đừng hôm nay niệm chú này, ngày mai đổi chú khác. Cả đời thầy chỉ trì một bộ Lăng Nghiêm Chú, đã hơn 80 năm rồi.

Thứ ba - Phải một lòng một dạ, kiên định.
Dù trời có sập xuống thầy vẫn ngồi niệm chú.

Các Phật tử xem cái am tranh của thầy đó, chẳng có gì hết, chỉ có mỗi cái giường ván. Tại sao? Là để cắt đứt vọng tưởng! Ở đây ngoài việc niệm chú ra thì không nghĩ gì khác.

Có người hỏi thầy: 『Bạch Lão Hòa Thượng, Hòa Thượng niệm chú có thấy cảnh giới gì không ạ?』
Thầy trả lời: 『Thầy chẳng thấy cảnh giới gì cả, chỉ biết thành thật mà niệm thôi!』
Các Phật tử nhớ nha: Đừng có mong cầu cảnh giới, càng cầu là càng bị ma chướng. Cứ thành thật niệm, tự nhiên sẽ có lợi ích.

Thầy mỗi ngày 3 giờ rưỡi sáng là thức dậy. Lạy Phật 100 lạy trước, rồi bắt đầu trì chú. Một ngày ít nhất 108 biến, dù mưa hay nắng cũng không bỏ.
Vì sao phải vậy? Vì chuyện sinh tử rất lớn, vô thường đến nhanh lắm!

Bây giờ có nhiều người vừa niệm chú vừa bấm điện thoại. Vậy gọi là trì chú gì? Đó là giỡn chơi đó!
Đã niệm thì phải niệm cho nghiêm túc. Không niệm thì thôi. Phật Bồ Tát không gạt ai bao giờ, chỉ có mình tự gạt mình thì không ai cứu được.

Cuối cùng thầy tặng các Phật tử một câu:
『Đánh tan vọng tưởng, thì pháp thân sẽ hiển lộ』
= Khi nào quý vị dẹp được hết vọng tưởng trong đầu, thì tánh Phật của quý vị sẽ sống lại. Lúc đó trì chú mới linh nghiệm!''',
    },
    {
      'title': 'MUỐN NHANH CHÓNG THÀNH TỰU, HÃY TỤNG THUỘC CHÚ LĂNG NGHIÊM',
      'meta': 'Hòa Thượng Phổ Quang',
      'preview': '''Lời Hòa thượng Phổ Quang

Niệm A Di Đà Phật, sau một trăm lẻ tám nghìn năm sẽ thành Phật, nhất định sẽ thành Phật! Đức A Di Đà từ bi, người nào niệm danh hiệu Ngài đều có thể thành Phật. Nhưng nếu bạn muốn nhanh chóng thành tựu, hãy hiếu thuận với cha mẹ và tụng thuộc Chú Lăng Nghiêm.

Tại sao khi tụng Chú Lăng Nghiêm lại phải phát âm vang rõ?

Nếu âm thanh quá nhỏ thì quỷ thần còn không nghe thấy, vậy bạn độ ai?

Âm thanh lớn, ngay cả các loài côn trùng, kiến cũng có thể nghe được mà kết duyên thành Phật. Đồng thời, việc trì tụng còn có thể làm tiêu trừ những vọng niệm của chính mình, khiến vọng niệm không thể quấy nhiễu tâm tính, hàng phục cơn buồn ngủ, khai thông kinh mạch, bổ sung dương khí và tăng cường thể chất.

NĂM ĐẠI TÂM CHÚ:

叱陀你 / SẤT ĐÀ NỂ
阿迦囉 / A CA LA
密唎柱 / MẬT RỊ TRỤ
般唎怛囉耶 / BÁT RỊ ĐÁT RA DA
儜揭唎 / NẢNH YẾT RỊ

Ba chữ là một câu. Năm câu này biểu thị Ngũ phương Phật hàng phục Ngũ phương ma.

Tôi nói đây là tâm chú chính thống của Chú Lăng Nghiêm (đại tâm chú). Có người nói tâm chú của Chú Lăng Nghiêm là câu cuối cùng, tức câu chú tâm. Tâm chú của Chú Lăng Nghiêm chính thống chính là trái tim của chư Phật. Chính câu này có năng lực khiến thiên hạ hòa bình.

Chú Lăng Nghiêm chính là do Đức Phật Thích Ca Mâu Ni tuyên thuyết. Ân đức của Phật thật khó báo đáp. Chú Lăng Nghiêm còn liên quan đến sự hưng suy của toàn thể Phật giáo, liên quan đến hết thảy chúng sinh. Trong trời đất này, không có gì quan trọng hơn Chú Lăng Nghiêm.

Vì vậy, chỉ cần tôi còn một hơi thở, tôi vẫn sẽ hết lòng hoằng dương thần chú Lăng Nghiêm này.

Tất cả mọi thứ trên thế gian đều là giả, ngay cả thân thể của lão Phổ Quang tôi đây cũng là giả. Chỉ có Chú Lăng Nghiêm là chân thật nhất. Vì vậy, tôi ngay cả chính mình cũng không tin, chỉ tin vào Chú Lăng Nghiêm này.

Cho nên, khi mọi người tham gia pháp hội thất nhật, mỗi ngày trì tụng thần chú, nhất định phải dùng tâm mà niệm, phải đem tâm chân thành ra để trì tụng. Đừng vừa niệm vừa khởi vọng tưởng, vừa niệm vừa nghi ngờ.

Bạn xem, khi tôi vừa niệm Chú Lăng Nghiêm thì ngay cả lão Phổ Quang tôi cũng không còn nữa. Toàn tâm đều hòa nhập vào việc trì chú.

Khi tụng thuộc câu trước thì nghĩ đến câu tiếp theo; tụng đến chữ trước thì nghĩ đến chữ tiếp theo. Cứ như vậy, nhất tâm bất loạn mà trì tụng thần chú. Cứ bám chặt lấy Chú Lăng Nghiêm, không buông bỏ, thì trong đời này nhất định có thể thành tựu.''',
    },
    {
      'title': 'NIỆM CHÚ LĂNG NGHIÊM BẢY NGÀY, CĂN BỆNH LẠ BỖNG NHIÊN KHỎI HẲN',
      'meta': 'Hòa Thượng Tuyên Hóa',
      'preview': '''宣化上人 - Tuyên Hóa Thượng Nhân:
Tôi kể cho các bạn nghe một câu chuyện có thật thế này: Ở vùng Đông Bắc Trung Quốc, có một người mắc phải căn bệnh lạ, bao nhiêu bác sĩ đều chữa không khỏi. Sau đó, ông ấy gặp được một vị lão tu hành dạy cho cách niệm Chú Lăng Nghiêm. Ông ấy đã thành tâm thành ý niệm suốt bảy ngày, và bệnh tình liền khỏi hẳn! Đây không phải là mê tín, mà chính là uy thần lực của Chú Lăng Nghiêm!

Người trì tụng Chú Lăng Nghiêm thì đi đến đâu cũng có thiện thần hộ pháp đi theo bảo vệ. Các bạn nhìn Tế Công Hòa Thượng xem, tại sao ngài lại có thể hàng yêu phục ma? Chính là dựa vào sức mạnh của Chú Lăng Nghiêm! Thần chú này vừa niệm lên một cái là yêu ma quỷ quái đều sợ hãi mà chạy trốn thật xa.

Thế nhưng, các bạn đừng có nghĩ rằng hễ niệm vài biến là có đại thần thông ngay nhé. Thời trẻ khi tôi niệm Chú Lăng Nghiêm, niệm đến mức rộp cả miệng ra mà vẫn tiếp tục niệm. Tại sao vậy? Bởi vì tôi biết công đức của thần chú này là không thể nghĩ bàn!

Bây giờ có rất nhiều người cứ mong cầu cảm ứng, niệm được vài ngày không thấy hào quang của Phật hiện ra là liền bỏ không niệm nữa. Như vậy thì gọi gì là tu hành? Kinh Lăng Nghiêm nói rất rõ ràng: "Nếu không trì giới, dẫu có tụng chú, chung quy cũng không phải là chính định." Bạn vừa ăn thịt uống rượu, lại vừa niệm chú, thì làm sao mà có hiệu quả cho được?

Hãy nhớ kỹ lời này của tôi: Trì Chú Lăng Nghiêm thì phải giống như ăn cơm vậy, một ngày cũng không thể thiếu. Sáng niệm, tối niệm, đi đường niệm, ngồi xe niệm, hãy niệm bài chú này vào tận trong tâm của mình. Cứ niệm như vậy suốt ba năm, bạn sẽ tự biết cái lợi ích của nó.

Cuối cùng tôi nói cho các bạn biết: Cái lợi ích lớn nhất của việc trì Chú Lăng Nghiêm không phải là cầu phát tài, cầu bình an, mà là để khai mở trí tuệ, để minh tâm kiến tính. Các bạn nhìn Hư Vân Lão Hòa Thượng xem, tại sao ngài lại có thể sống đến 120 tuổi? Chính là vì ngày ngày ngài đều trì Chú Lăng Nghiêm!

(Trích từ bài khai thị "Công đức của Chú Lăng Nghiêm" của Tuyên Hóa Thượng Nhân, Vạn Phật Thánh Thành)''',
    },
  ];

  List<Map<String, String>> get _filteredTeachings {
    return _allTeachings.where((teaching) {
      final currentFilter = _filters[_selectedChipIndex];
      return teaching['meta']! == currentFilter;
    }).toList();
  }

  String get _selectedTeacherImage => _selectedChipIndex == 0
      ? 'assets/images/teacher-tuyen-hoa.jpeg'
      : 'assets/images/teacher-pho-quang.webp';

  Widget _buildTeacherHero(int teachingCount, bool isPhone) {
    final imageWidth = isPhone ? 68.0 : 150.0;
    return ClipRRect(
      key: const Key('teacher-hero'),
      borderRadius: BorderRadius.circular(22),
      child: SizedBox(
        height: isPhone ? 84 : 185,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppPalette.glassPanelHighlight,
                    AppPalette.glassPanel,
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: isPhone ? 8 : 14,
              bottom: isPhone ? 8 : 14,
              child: Center(
                child: SizedBox(
                  width: imageWidth,
                  height: isPhone ? 68 : 157,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      _selectedTeacherImage,
                      key: const Key('selected-teacher-image'),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      semanticLabel: 'Ảnh vị giảng sư đang được chọn',
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: isPhone ? 10 : 16,
              bottom: isPhone ? 8 : 14,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isPhone ? 8 : 11,
                  vertical: isPhone ? 4 : 7,
                ),
                decoration: BoxDecoration(
                  color: AppPalette.glassPanel,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0x99D4AF37)),
                ),
                child: Text(
                  '$teachingCount bài',
                  style: TextStyle(
                    color: const Color(0xFFF4D35E),
                    fontSize: isPhone ? 10 : 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _filteredTeachings;
    final isPhone = MediaQuery.sizeOf(context).width < 600;

    return Scaffold(
      body: CustomScrollView(
        key: const Key('teachings-scroll'),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              isPhone ? 12 : 20,
              isPhone ? 8 : 16,
              isPhone ? 12 : 20,
              0,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: Row(
                        children: List.generate(_filters.length, (index) {
                          final isSelected = _selectedChipIndex == index;
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: index == 0 ? 5 : 0,
                                left: index == 1 ? 5 : 0,
                              ),
                              child: ChoiceChip(
                                key: ValueKey('teacher-tab-$index'),
                                label: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    _filters[index],
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                selected: _selectedChipIndex == index,
                                showCheckmark: false,
                                onSelected: (selected) {
                                  if (selected) {
                                    setState(() => _selectedChipIndex = index);
                                  }
                                },
                                backgroundColor: AppPalette.glassPanel,
                                selectedColor: const Color(0xFFD4AF37),
                                padding: EdgeInsets.symmetric(
                                  horizontal: isPhone ? 4 : 12,
                                  vertical: isPhone ? 9 : 12,
                                ),
                                labelStyle: TextStyle(
                                  color: isSelected
                                      ? const Color(0xFF1B2D38)
                                      : const Color(0xFFFDF5E6),
                                  fontSize: isPhone ? 11 : 15,
                                  fontWeight: FontWeight.w800,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                  side: BorderSide(
                                    color: isSelected
                                        ? const Color(0xFFD4AF37)
                                        : const Color(0xB3D4AF37),
                                    width: isSelected ? 1.8 : 1.2,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildTeacherHero(filteredList.length, isPhone),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              isPhone ? 12 : 20,
              0,
              isPhone ? 12 : 20,
              24,
            ),
            sliver: SliverList.separated(
              itemCount: filteredList.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = filteredList[index];
                return Container(
                  key: ValueKey('teaching-${item['title']}'),
                  padding: EdgeInsets.all(isPhone ? 16 : 22),
                  decoration: BoxDecoration(
                    color: AppPalette.glassPanel,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0x33D4AF37)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x30000000),
                        blurRadius: 16,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title']!,
                        style: TextStyle(
                          color: const Color(0xFFF4D35E),
                          fontWeight: FontWeight.bold,
                          fontSize: isPhone ? 17 : 19,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item['preview']!,
                        style: TextStyle(
                          color: const Color(0xFFFDF5E6),
                          fontSize: isPhone ? 15 : 16,
                          height: 1.65,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
