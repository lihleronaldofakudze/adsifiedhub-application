class Package {
  final String name;
  final double amount;
  final String duration;

  Package({required this.name, required this.amount, required this.duration});
}

final packages = [
  Package(
    name: "Free",
    amount: 0,
    duration: "7 days",
  ),
  Package(
    name: "Silver",
    amount: 1.0,
    duration: "14 days",
  ),
  Package(
    name: "Gold",
    amount: 1.1,
    duration: "30 days",
  ),
  Package(
    name: "Platinum",
    amount: 1.5,
    duration: "60 days",
  ),
];
