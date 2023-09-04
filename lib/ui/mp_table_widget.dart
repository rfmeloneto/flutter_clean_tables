import 'package:flutter/material.dart';

class MpTableWidget extends StatelessWidget {
  const MpTableWidget({
    super.key,
    required this.header,
    required this.body,
    required this.onTap,
  });

  final List<String> header;
  final List<Map<String, dynamic>> body;
  final void Function(int index) onTap;

  String _header(String item) {
    final header = HeaderTitle.values.firstWhere(
      (e) => e.name == item,
      orElse: () => HeaderTitle.none,
    );

    if (header == HeaderTitle.none) {
      return item;
    }

    return header.title;
  }

  bool _hide(String code) {
    final data = HideValue.values.where((e) => e.code == code);

    final hide = data.isEmpty;

    return hide;
  }

  bool _hideBody(MapEntry entry) {
    final data = HideValue.values.where((e) => e.code == entry.key);

    final hide = data.isEmpty;

    return hide;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: header.where(_hide).map((e) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Text(_header(e)),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        const Divider(),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.separated(
            itemCount: body.length,
            separatorBuilder: (_, __) {
              return const Divider(height: 12);
            },
            itemBuilder: (_, index) {
              final item = body.elementAt(index);

              return InkWell(
                onTap: () => onTap(index),
                child: Row(
                  children: item.entries.where(_hideBody).map((entry) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(entry.value.toString()),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

enum HeaderTitle {
  // position('Posição'),
  // speciality('Especialidade'),
  // total_vacancies('Vagas'),
  // number_of_vacancies('Vagas Ocupadas'),
  none('');

  const HeaderTitle(this.title);

  final String title;
}

enum HideValue {
  modifiedBy('modified_by'),
  modifiedAt('modified_at'),
  createdBy('created_by_unicode');

  const HideValue(this.code);

  final String code;
}
