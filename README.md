# 🚀 GoalFlow – Ứng dụng theo dõi mục tiêu và thói quen

---

## 📌 Giới thiệu

**GoalFlow** là ứng dụng hỗ trợ người dùng theo dõi **mục tiêu cá nhân (Goal)** và xây dựng **thói quen (Habit)** mỗi ngày.
Ứng dụng giúp duy trì động lực thông qua việc ghi nhận tiến trình và nhắc nhở thường xuyên.

---

## 👥 Thành viên nhóm

* Nguyễn Minh Ánh – MASV: 23010718
* Mai Ngọc Linh – MASV: 230101717

---

## 📖 Mô tả dự án

Trong cuộc sống hiện đại, việc duy trì thói quen tốt và hoàn thành mục tiêu cá nhân là một thách thức lớn.
**GoalFlow** được xây dựng nhằm hỗ trợ người dùng:

* Theo dõi tiến trình mục tiêu
* Xây dựng thói quen tích cực
* Duy trì kỷ luật cá nhân

---

## 🎯 Đối tượng quản lý

Ứng dụng tập trung vào 3 đối tượng chính:

* 👤 **User** – người sử dụng hệ thống
* 🎯 **Goal** – mục tiêu cá nhân
* 🔥 **Habit** – thói quen hằng ngày

---

## 🧠 Nội dung bài tập (OOP)

### ✨ Câu 2: Generics

Xây dựng lớp tổng quát giúp xử lý dữ liệu linh hoạt.

📄 File:

```bash
lib/cau2_utils/generic.dart
```

---

### ✨ Câu 3: Xây dựng Class Habit

📄 File:

```bash
lib/cau3_models/habit.dart
```

#### 🔹 Thuộc tính:

* `id`
* `tenHabit`
* `tanSuat`
* `thoiGianNhac`

#### 🔹 Phương thức:

* `display()`
* `update(...)`

👉 Class Habit đại diện cho một thói quen cụ thể của người dùng.

---

### ✨ Câu 4: CRUD với ListHabit

📄 File:

```bash
lib/cau4_managers/list_habit.dart
```

#### 🔹 Danh sách:

```dart
List<Habit> habits = [];
```

#### 🔹 Chức năng:

* ✅ Create: `addHabit()`
* ✅ Read: `getAllHabits()`
* ✅ Update: `updateHabit()`
* ⭐ Delete: `deleteHabit()` (mở rộng)

👉 Class này đóng vai trò quản lý danh sách Habit và xử lý logic dữ liệu.

---

## 🖥️ Giao diện

📄 File chính:

```bash
lib/main.dart
```

Ứng dụng hiển thị:

* Thông tin người dùng
* Danh sách Goal
* Danh sách Habit

👉 Giao diện đơn giản, tập trung vào hiển thị dữ liệu.

---

## ⚙️ Công nghệ sử dụng

* 💙 Flutter
* 🎯 Dart
* 🧠 OOP (Object-Oriented Programming)
* 🐳 Dev Container (Docker)
* ☁️ GitHub Codespaces

---

## 🛠️ Chức năng chính

* ✅ Tạo và quản lý mục tiêu
* ✅ Theo dõi tiến độ
* ✅ Quản lý thói quen
* ✅ Hiển thị dữ liệu rõ ràng

---

## 📂 Cấu trúc dự án

```bash
lib/
│
├── cau2_utils/
│   └── generic.dart
│
├── cau3_models/
│   └── habit.dart
│
├── cau4_managers/
│   └── list_habit.dart
│
├── screens/
├── widgets/
├── models/
├── services/
│
└── main.dart
```

---

## ▶️ Cách chạy project

```bash
flutter pub get
flutter run -d web-server
```

---

## 📝 Ghi chú

* Dự án được phát triển trên Dev Container
* Có thể chạy trực tiếp trên GitHub Codespaces
* Tập trung vào logic OOP hơn là UI

---

## 👨‍💻 Tác giả

**Nhóm N03 – GoalFlow Project**

---

