import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/FAQViewModel.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FAQViewModel(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 70,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Theme.of(context).iconTheme.color,
                  size: 18,
                ),
              ),
            ),
          ),
          title: Text(
            "FAQS",
            style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
          ),
          centerTitle: false,
        ),
        body: Consumer<FAQViewModel>(
          builder: (context, viewModel, child) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: viewModel.faqs.length,
              separatorBuilder: (context, index) => Divider(
                color: Theme.of(context).dividerColor,
                thickness: 0.5,
              ),
              itemBuilder: (context, index) {
                final faq = viewModel.faqs[index];
                return Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    iconColor: Theme.of(context).iconTheme.color,
                    collapsedIconColor: Theme.of(context).iconTheme.color,
                    title: Text(
                      faq['question']!,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    trailing: const Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          faq['answer']!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
