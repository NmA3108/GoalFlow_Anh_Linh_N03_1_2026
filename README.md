# GoalFlow - Habit Tracker Mood Community

GoalFlow là ứng dụng Flutter giúp người dùng tạo thói quen, theo dõi chuỗi ngày hoàn thành, ghi lại tâm trạng và xem thống kê cá nhân. Giao diện được phát triển theo thiết kế Figma **Habit Tracker Mood Community**.

## Thành viên

- Nguyễn Minh Ánh - MASV: 23010718
- Mai Ngọc Linh - MASV: 230101717

## Công nghệ

- Flutter, Dart và Material Design 3
- Firebase Core và Cloud Firestore
- `flutter_local_notifications`
- `timezone` và `flutter_timezone`
- Figma làm tài liệu thiết kế

## Chức năng

### Home và thói quen

- Đọc danh sách thói quen realtime từ Firestore.
- Tạo thói quen theo flow nhiều bước.
- Chọn lĩnh vực, lý do, lịch thực hiện và giờ nhắc.
- Đánh dấu hoàn thành hoặc chưa hoàn thành theo từng ngày.
- Tách danh sách hôm nay và nhiệm vụ đã hoàn thành.
- Tính chuỗi ngày hiện tại từ các `habitLogs`.
- Hiển thị đúng các ngày thuộc chuỗi như `CN`, `T2`, `T3`.
- Chuỗi dài có thể cuộn ngang.

### Nhắc nhở

- Chọn giờ thật bằng time picker.
- Lưu `reminderEnabled` và `reminderTime` vào habit document.
- Android lập lịch local notification theo các ngày đã chọn.
- Lịch Android được khôi phục sau khi thiết bị khởi động lại.
- Web hiển thị browser notification khi tab ứng dụng vẫn đang mở.
- Người dùng có thể tắt lời nhắc và hủy lịch đã tạo.

### Reflection và tâm trạng

- Lưu điểm tâm trạng, cảm xúc, hoạt động và ghi chú theo ngày.
- Đọc bản ghi gần nhất trên màn Nhìn lại.
- Hiển thị biểu đồ tâm trạng trong tuần.
- Tính điểm tâm trạng trung bình từ dữ liệu Firestore.

### Thống kê

- Thống kê số lần hoàn thành theo từng ngày trong tuần.
- Tính chuỗi hiện tại và chuỗi dài nhất.
- Tính tổng số phút đã dành cho thói quen.
- Tab tổng quan và phân tích cá nhân đều dùng dữ liệu thật.

### Sự Thấu Hiểu

- Đọc danh sách sách và podcast từ `healingContents`.
- Vuốt các thẻ bằng `PageView`.
- Tự chuyển thẻ sau mỗi 5 giây.
- Chỉ báo trang cập nhật theo thẻ hiện tại.
- Nhấn thẻ để mở nội dung chi tiết.
- Tiêu đề và mô tả được giới hạn dòng để không chồng chữ.

### Các màn hình khác

- Login, Register, Forgot Password và Verify OTP.
- Cài đặt đọc tên và email từ user document.
- Chỉnh sửa thói quen.
- Premium/Price.
- Bottom navigation theo prototype Figma.

## Object-document mapping

Các model nằm trong `lib/data/app_models.dart`:

- `AppUser`
- `HabitRecord`
- `HabitLog`
- `ReflectionRecord`
- `HealingContent`
- `HabitStatistics`

Repository dùng chung nằm trong `lib/data/app_repository.dart`.

## Cấu trúc Firestore

```text
users/{userId}
  displayName
  email
  createdAt

users/{userId}/habits/{habitId}
  name
  area
  days[]
  reason
  reminderEnabled
  reminderTime
  active
  createdAt

users/{userId}/habitLogs/{dateKey_habitId}
  habitId
  dateKey
  completed
  minutes
  completedAt

users/{userId}/reflections/{dateKey}
  dateKey
  moodScore
  emotions[]
  activities[]
  note
  createdAt

healingContents/{contentId}
  title
  subtitle
  type
  author
  url
  imageUrl
  order
```

Ứng dụng hiện sử dụng `demo-user`. Khi hoàn thiện Firebase Authentication, cần thay bằng UID của tài khoản đăng nhập.

## Cấu trúc source

```text
myproject/lib/
├── data/
│   ├── app_models.dart
│   └── app_repository.dart
├── services/
│   └── reminder_service.dart
├── pages/
│   ├── auth_pages.dart
│   ├── create_habit_flow.dart
│   ├── insight_general_page.dart
│   ├── insight_page.dart
│   ├── reflection_page.dart
│   └── settings_pages.dart
├── theme/
│   └── app_design.dart
├── firebase_options.dart
├── main.dart
└── MyHomePage.dart
```

## Chạy dự án

```bash
cd myproject
flutter pub get
flutter run
```

Chạy web:

```bash
flutter run -d web-server --web-hostname 127.0.0.1 --web-port 8090
```

Kiểm tra và build:

```bash
flutter test
flutter build web
flutter build apk --debug
```

## Lưu ý

- Trình duyệt không hỗ trợ scheduled notification khi tab đã đóng.
- Android cần quyền thông báo và quyền báo thức chính xác.
- Firestore Rules cần được giới hạn theo UID trước khi phát hành production.
- Một số ảnh minh họa đang dùng custom painter hoặc icon thay cho asset Figma gốc.
