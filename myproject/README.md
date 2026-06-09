# GoalFlow Flutter App

Ứng dụng Flutter theo dõi thói quen, tâm trạng và thống kê cá nhân theo thiết kế Figma **Habit Tracker Mood Community**.

## Chức năng

- Home hiển thị danh sách thói quen realtime từ Cloud Firestore.
- Tạo thói quen nhiều bước và lưu thành document thật.
- Đánh dấu hoàn thành hoặc chưa hoàn thành theo từng ngày.
- Tính chuỗi ngày liên tiếp hiện tại và chuỗi dài nhất từ lịch sử hoàn thành.
- Thống kê số lần hoàn thành theo tuần và tổng thời gian đã dành.
- Reflection lưu tâm trạng, cảm xúc, hoạt động và ghi chú theo ngày.
- Thống kê tâm trạng trung bình và biểu đồ tâm trạng tuần.
- Mục Sự Thấu Hiểu đọc sách/podcast từ Firestore.
- Các thẻ nội dung có thể vuốt, tự chuyển trang và mở chi tiết.
- Cài đặt đọc tên và email từ document người dùng.
- Chọn giờ nhắc bằng time picker và lưu `reminderTime` vào habit document.
- Android lập lịch local notification theo ngày đã chọn, kể cả khi đóng app.
- Web hiển thị browser notification khi ứng dụng vẫn đang mở.
- Bottom navigation, tạo mới, đăng nhập, đăng ký, quên mật khẩu, OTP.
- Chỉnh sửa thói quen, nhắc nhở và trang Premium.

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

Hiện ứng dụng dùng `demo-user` để chạy dữ liệu mẫu. Khi tích hợp Firebase Authentication, thay `demo-user` bằng `FirebaseAuth.instance.currentUser!.uid`.

## File chính

```text
lib/
├── data/
│   ├── app_models.dart
│   └── app_repository.dart
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

## Chạy ứng dụng

```bash
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

## Lưu ý Firebase

- Firebase đã được cấu hình cho Android và Web.
- Dữ liệu mẫu chỉ được tạo khi collection tương ứng đang trống.
- Firestore Rules hiện cần được siết lại trước khi đưa ứng dụng lên production.
- Home chỉ dùng dữ liệu fallback khi Firebase chưa khởi tạo, chủ yếu phục vụ widget test.
- Trình duyệt không hỗ trợ lịch thông báo nền. Trên web phải giữ tab ứng dụng mở.
- Người dùng phải cấp quyền thông báo và quyền báo thức chính xác trên Android.
