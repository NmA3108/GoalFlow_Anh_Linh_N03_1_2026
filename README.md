# GoalFlow - Habit Tracker Mood Community

GoalFlow là ứng dụng Flutter giúp người dùng xây dựng thói quen, theo dõi chuỗi ngày hoàn thành, ghi lại tâm trạng hằng ngày và xem thống kê cá nhân. Giao diện được phát triển theo thiết kế Figma **Habit Tracker Mood Community**.

## Thành viên nhóm

- Nguyễn Minh Ánh - MASV: 23010718
- Mai Ngọc Linh - MASV: 230101717

## Công nghệ sử dụng

- Flutter
- Dart
- Firebase Core
- Cloud Firestore
- Material Design 3
- Figma design reference

## Chức năng đã triển khai

### 1. Màn hình Daily/Home

- Hiển thị thời gian giả lập theo thiết kế mobile.
- Hiển thị streak: `2 ngày liên tiếp`.
- Hiển thị thói quen trong ngày.
- Hiển thị danh sách nhiệm vụ đã hoàn thành.
- Bottom navigation gồm:
  - Daily/Home
  - Insight/Statistics
  - Create Habit
  - Reflection/Mood
  - Community/Insight
- Bấm icon cài đặt trên Home để mở màn hình `Cài đặt`.
- Bấm task `Học Tiếng Anh` để mở màn hình chỉnh sửa thói quen.

### 2. Tạo thói quen mới

Flow tạo thói quen được tách thành nhiều bước theo Figma:

- Nhập tên thói quen.
- Chọn lĩnh vực thói quen cải thiện, ví dụ `Tâm trí`.
- Chọn lịch hoàn thành:
  - Mỗi ngày
  - Tùy chọn ngày
  - Chọn các ngày trong tuần
- Viết lý do tạo động lực.
- Thiết lập lời nhắc.
- Hoàn thành tạo thói quen.

### 3. Bottom Sheet tạo mới

Khi bấm nút `+` ở bottom navigation, app mở bottom sheet gồm:

- `Tạo 1 thói quen mới`
- `Nhật kí hằng ngày`

### 4. Reflection / Mood Journal

- Màn hình `Nhìn lại` hiển thị các ngày đã ghi nhận tâm trạng.
- Hiển thị thông tin tâm trạng theo ngày.
- Hiển thị suy nghĩ, cảm xúc và hoạt động đã chọn.
- Hiển thị biểu đồ tuần.
- Hiển thị điểm tâm trạng trung bình.
- Màn hình chọn cảm xúc hiện tại:
  - Tự hào
  - Mơ hồ
  - Bình yên
  - Hưng phấn
  - Buồn
  - Hạnh phúc
  - Bất ổn
  - Bất lực
  - Lo âu
  - Biết ơn
  - Yêu thương
  - Tức giận
  - Bình thản
  - Sáng tạo
  - Phân tâm
  - Quyết tâm
  - Tự ti
  - Hoài niệm
- Màn hình chọn hoạt động trong ngày:
  - Thể thao
  - Tình yêu
  - Bạn bè
  - Công việc
  - Học
  - Chăm sóc
  - Việc nhà
  - Thiên nhiên
  - Thư giãn
- Màn hình nhập ghi chú cá nhân.

### 5. Insight / Thống kê

Màn hình thống kê gồm 2 tab:

- `Tổng quan`
- `Cá nhân`

Chức năng tab `Tổng quan`:

- Thống kê thói quen đã hoàn thành trong tuần.
- Heatmap mức độ hoàn thành.
- Thống kê tâm trạng hằng ngày.
- Chú giải mức tâm trạng từ `Tồi tệ` đến `Tốt hơn`.
- Premium card: `Mở khóa bản Premium để xem thêm thống kê`.

Chức năng tab `Cá nhân`:

- Hiển thị thói quen `Luyện nghe tiếng Anh`.
- Hiển thị chuỗi ngày: `10 Chuỗi ngày`.
- Hiển thị gợi ý theo dõi đủ 10 ngày để xem kết quả.
- Lịch tháng với trạng thái:
  - Hoàn thành
  - Hôm nay
  - Chưa hoàn thành
  - Chưa theo dõi
- Hiển thị ngày theo dõi thói quen.
- Hiển thị thời gian đã dành.
- Hiển thị chuỗi dài nhất.

### 6. Community / Insight Story

- Màn hình `Sự Thấu Hiểu`.
- Hiển thị carousel các bài viết/thẻ nội dung.
- Hiển thị chỉ báo trang.
- Có bottom navigation đồng bộ với toàn app.

### 7. Auth

Đã thêm các màn hình xác thực theo Figma:

- Login
- Register
- Forgot Password
- Verify OTP
- Continue with Google
- Continue with Apple
- Continue as Guest

### 8. Cài đặt

Màn hình `Cài đặt` gồm:

- Thông tin ứng dụng.
- Tài khoản người dùng.
- Email người dùng.
- Cài đặt chung:
  - Chế độ tối
  - Hiển thị kiểm tra trách nhiệm
  - Hiển thị các thói quen sắp tới
  - Hiển thị kiểm tra tâm trạng hằng ngày
- Thay đổi thứ tự thói quen.
- Mở khóa Premium.
- Đánh giá ứng dụng 5 sao.
- Liên hệ nhà phát triển.
- Chia sẻ với bạn bè.
- Giấy phép.
- Đăng xuất.
- Xóa tài khoản.

### 9. Premium / Price

Màn hình Premium gồm:

- Danh sách quyền lợi:
  - Không giới hạn thói quen và nhật ký
  - Đánh bại sự trì hoãn
  - Thống kê tâm trạng và thói quen
  - Động lực hằng ngày
- Gói năm.
- Gói tháng.
- Đánh giá người dùng.
- Điều khoản đăng ký.
- Nút tiếp tục.

### 10. Chỉnh sửa thói quen

- Xem và sửa tên thói quen.
- Xóa thói quen.
- Tạo/chỉnh lời nhắc.
- Xem và sửa lý do.
- Chỉnh sửa nhóm thói quen.
- Chọn ngày trong tuần.
- Chọn lĩnh vực thói quen.
- Lưu thay đổi.

### 11. Nhắc nhở

- Màn hình chọn thời gian nhắc nhở.
- Hủy nhắc nhở.
- Hoàn thành thiết lập nhắc nhở.

### 12. Firebase

- App có khởi tạo Firebase trong `main.dart`.
- Đã khai báo dependencies:
  - `firebase_core`
  - `cloud_firestore`
- Firebase config hiện có cho Android, Web, iOS, macOS và Windows.
- Flow tạo thói quen lưu dữ liệu vào collection `habits`.
- Home đọc danh sách thói quen realtime bằng `StreamBuilder`.
- Bấm task cập nhật trường `completed` trên Firestore.

Document trong collection `habits`:

```text
name
area
days
reason
reminderEnabled
reminderTime
completed
createdAt
completedAt
```

### 13. OOP / Model

- Class `Goal`:
  - `idGoal`
  - `tenGoal`
  - `ngayBatDau`
  - `ngayKetThuc`
  - `tienDo`
  - Hiển thị thông tin
  - Cập nhật tiến độ
  - Kiểm tra hoàn thành
- Class `ListGoal`:
  - Create
  - Read
  - Edit
  - Delete

## Cấu trúc source chính

```bash
myproject/lib/
├── main.dart
├── MyHomePage.dart
├── firebase_options.dart
├── goal.dart
├── list_goal.dart
├── navigation/
│   └── home_page_navigation.dart
├── pages/
│   ├── auth_pages.dart
│   ├── create_habit_flow.dart
│   ├── insight_general_page.dart
│   ├── insight_page.dart
│   ├── reflection_page.dart
│   └── settings_pages.dart
└── theme/
    └── app_design.dart
```

## Cách chạy project

```bash
cd myproject
flutter pub get
flutter run
```

Chạy web server:

```bash
flutter run -d web-server --web-hostname 127.0.0.1 --web-port 8080
```

Build web:

```bash
flutter build web
```

## Kiểm thử

Chạy test:

```bash
flutter test
```

Test hiện tại kiểm tra:

- App render được dashboard Daily.
- Hiển thị streak và task.
- Bấm nút `+` mở bottom sheet tạo mới.

## Ghi chú

- Một số hình minh họa trong Figma hiện được dựng bằng icon/custom widget thay vì asset gốc.
- Để UI sát pixel hơn, cần export asset từ Figma vào project và khai báo trong `pubspec.yaml`.
- Phần dữ liệu hiện chủ yếu là dữ liệu mẫu trên UI; Firestore dependency đã có nhưng chưa mapping đầy đủ toàn bộ object-document vào giao diện.
