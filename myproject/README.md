# GoalFlow Flutter App

Ứng dụng Flutter theo dõi thói quen, tâm trạng và thống kê cá nhân theo thiết kế Figma **Habit Tracker Mood Community**.

## Chức năng

- Daily/Home dashboard
- Bottom navigation
- Bottom sheet tạo mới
- Flow tạo thói quen nhiều bước
- Reflection / Mood journal
- Chọn cảm xúc hiện tại
- Chọn hoạt động trong ngày
- Ghi chú nhật ký
- Insight / Thống kê tổng quan
- Insight / Phân tích cá nhân
- Community carousel
- Login
- Register
- Forgot password
- Verify OTP
- Cài đặt
- Premium / Price
- Chỉnh sửa thói quen
- Thiết lập nhắc nhở
- Model OOP `Goal` và `ListGoal`
- Firebase initialization

## File chính

```bash
lib/
├── main.dart
├── MyHomePage.dart
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

## Chạy app

```bash
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

Chạy test:

```bash
flutter test
```

## Ghi chú

- UI đã dựng theo frame Figma chính.
- Một số asset minh họa đang dùng icon/custom widget thay vì ảnh export từ Figma.
- Firestore dependency đã khai báo, nhưng dữ liệu UI hiện vẫn chủ yếu là dữ liệu mẫu.

