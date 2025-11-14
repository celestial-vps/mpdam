// import 'package:flutter/material.dart';

// class BankSearchBar extends StatelessWidget {
//   final TextEditingController controller;
//   final ValueChanged<String> onChanged;
//   final VoidCallback onClear;

//   const BankSearchBar({
//     super.key,
//     required this.controller,
//     required this.onChanged,
//     required this.onClear,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           hintText: 'Cari Bank...',
//           prefixIcon: const Icon(Icons.search),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           suffixIcon: controller.text.isNotEmpty
//               ? IconButton(
//                   icon: const Icon(Icons.clear),
//                   onPressed: onClear,
//                 )
//               : null,
//         ),
//         // onChanged: onChanged,
//         onSubmitted: onChanged,
//       ),
//     );
//   }
// }
