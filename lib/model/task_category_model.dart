const String kTaskCatId = 'id';
const String kCategoryTitle = 'category';
const String kColor = 'color';
const String kIconCodePoint = 'code_point';
const String kIconFontFamily = 'font_family';
const String kIconFontPackage = 'font_package';
const String kHasTextDirectionMatched = 'text_direction';

class TaskCategoryModel {
  int? id;
  String categoryTitle;
  int color;
  int iconCodePoint;
  String? iconFontFamily;
  String? iconFontPackage;
  bool hasTextDirectionMatched;

  TaskCategoryModel(
      {this.id,
      required this.categoryTitle,
      required this.color,
      required this.iconCodePoint,
      this.iconFontFamily,
      this.iconFontPackage,
      this.hasTextDirectionMatched = false});

  factory TaskCategoryModel.fromMap(Map<String, dynamic> map) {
    return TaskCategoryModel(
      id: map[kTaskCatId],
      categoryTitle: map[kCategoryTitle],
      color: map[kColor],
      iconCodePoint: map[kIconCodePoint],
      iconFontFamily: map[kIconFontFamily],
      iconFontPackage: map[kIconFontPackage],
      hasTextDirectionMatched:
          map[kHasTextDirectionMatched] == 0 ? false : true,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      kTaskCatId: id,
      kCategoryTitle: categoryTitle,
      kColor: color,
      kIconCodePoint: iconCodePoint,
      kIconFontFamily: iconFontFamily,
      kIconFontPackage: iconFontPackage,
      kHasTextDirectionMatched: hasTextDirectionMatched == false ? 0 : 1,
    };
  }
}
