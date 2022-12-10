class Product {
  final String image, title, description, addInfo;
  final int id;
  final double price;

  Product(
      {required this.id,
      required this.title,
      required this.image,
      required this.price,
      required this.description,
      required this.addInfo});
}

List<Product> products = [
  Product(
      id: 1,
      title: "REMDII® Sensitive Scalp Repair Spray 30ml",
      image: "assets/images/remdii_senstive_scalp_repair_spray.png",
      price: 32.00,
      description:
          "A non-oily and lightweight moisturising spray to soothe dry, itchy and flaky scalp without leaving your hair greasy and flat. Formulated with botanical actives and vitamin E. Offers instant moisturisation by calming the redness and reducing the scalp oiliness and flaking in 2 weeks’ time. The addition of skin identical actives binds to the skin layer perfectly, trapping in moisture and protects the skin against dehydration.",
      addInfo:
          "WHAT IT IS \n 1. Effective botanical active ingredients paired with innovative mechanism \n Reduce dandruff, flaking, redness, itchiness and oiliness \n 2. Enriched with Vitamin E \n Provides instant moisturisation to balance and repair damaged scalp \n 3. Lightweight, gentle and non-oily spray \n Formulation suitable for delicate baby’s scalp, adults, under hijabs. It will not leave hair greasy or flat, can be used on dry, sensitive, normal, oily or flaky scalp."),
  Product(
      id: 2,
      title: "REMDII® Calming Body Wash 250ml",
      image: "assets/images/REMDII Calming Body Wash.png",
      price: 32.00,
      description:
          "This refreshing body wash enriched with vitamin E to remove dirt thoroughly while maintaining skin moisturized",
      addInfo:
          "WHAT IT IS \n 1. Enriched with vitamin E \n Instant hydration with highly moisturizing water formula \n 2. Soap- and sulphate-free \n A mild and non-foaming formulation that gently cleanses your skin, leaving your skin feeling fresh \n 3. Mild pH \n The pH of the formulated body wash is similar to the pH of a healthy human skin which helps to maintain the skin’s barrier function and prevents skin from drying out."),
  Product(
      id: 3,
      title: "REMDII® Intensive Moisturising Cream 112ml",
      image: "assets/images/REMDII Intensive Moisturising Cream 112ml.png",
      price: 85.00,
      description:
          "A lightweight intensive moisturizing cream formulated with bioengineered vitamin E, which provides instant hydration to relieve dry skin",
      addInfo:
          "✔ Suitable for Normal & Dry skin \n ✔ Non-oily & sticky \n ✔ Formulated with a full spectrum of tocopherols and tocotrienols (vitamin E) \n ✔ Dual Moisture-Maintain Technology with aloe vera and hyaluronic acid \n ✔ Fast absorption"),
  Product(
      id: 4,
      title: "REMDII® Intensive Moisturising Cream 250ml",
      image: "assets/images/REMDII Intensive Moisturising Cream 250ml.png",
      price: 150.00,
      description:
          "A lightweight intensive moisturizing cream formulated with bioengineered vitamin E, which provides instant hydration to relieve dry skin",
      addInfo:
          "✔ Suitable for Normal & Dry skin \n ✔ Non-oily & sticky \n ✔ Formulated with a full spectrum of tocopherols and tocotrienols (vitamin E) \n ✔ Dual Moisture-Maintain Technology with aloe vera and hyaluronic acid \n ✔ Fast absorption"),
  Product(
      id: 5,
      title: "REMDII® Intensive Moisturising Cream 50ml",
      image: "assets/images/intensive_moisturing_cream.png",
      price: 50.00,
      description:
          "A lightweight intensive moisturizing cream formulated with bioengineered vitamin E, which provides instant hydration to relieve dry skin",
      addInfo:
          "✔ Suitable for Normal & Dry skin \n ✔ Non-oily & sticky \n ✔ Formulated with a full spectrum of tocopherols and tocotrienols (vitamin E) \n ✔ Dual Moisture-Maintain Technology with aloe vera and hyaluronic acid \n ✔ Fast absorption"),
  Product(
      id: 6,
      title: "REMDII®Intensive Moisturising Cream 28ml",
      image: "assets/images/intensive_moisturing_cream_28ml.png",
      price: 30.00,
      description:
          "A lightweight intensive moisturizing cream formulated with bioengineered vitamin E, which provides instant hydration to relieve dry skin",
      addInfo:
          "✔ Suitable for Normal & Dry skin \n ✔ Non-oily & sticky \n ✔ Formulated with a full spectrum of tocopherols and tocotrienols (vitamin E) \n ✔ Dual Moisture-Maintain Technology with aloe vera and hyaluronic acid \n ✔ Fast absorption"),
  Product(
      id: 7,
      title: "REMDII® Ultra Sensitive Intensive Barrier Repair Cream 50ml",
      image:
          "assets/images/REMDII Ultra Sensitive Intensive Barrier Repair Cream 50ml.png",
      price: 80.00,
      description:
          "A nourishing rich texture intensive moisturizing cream that provides deep skin moisturized, makes it ideal for intensive and long-lasting skin hydration",
      addInfo:
          "✔ Suitable for dry skin \n ✔ Suitable for extremely dry skin \n ✔ Strengthen the skin moisture barrier with skin mimic technology ceramide complex in 3:1:1 ratio \n ✔ Formulated with a full spectrum of tocopherols and tocotrienols (vitamin E) \n ✔ Shea butter-based cream \n ✔ Contains Skin Mimic Ceramide"),
  Product(
      id: 8,
      title: "REMDII® Ultra Sensitive Intensive Barrier Repair Cream 150ml",
      image:
          "assets/images/REMDII Ultra Sensitive Intensive Barrier Repair Cream 150ml.png",
      price: 150.00,
      description:
          "A nourishing rich texture intensive moisturizing cream that provides deep skin moisturized, makes it ideal for intensive and long-lasting skin hydration.",
      addInfo:
          "✔ Suitable for dry skin \n ✔ Suitable for extremely dry skin \n ✔ Strengthen the skin moisture barrier with skin mimic technology ceramide complex in 3:1:1 ratio \n ✔ Formulated with a full spectrum of tocopherols and tocotrienols (vitamin E) \n ✔ Shea butter-based cream \n ✔ Contains Skin Mimic Ceramide"),
  Product(
      id: 9,
      title: "REMDII® Gentle Hair Shampoo 250ml",
      image: "assets/images/hair-shampoo.png",
      price: 36.00,
      description:
          "A revitalizing and gentle formulation, which provides an instant moisturizing and soothing effect to the scalp",
      addInfo:
          "✔ Enriched with Vitamin E \n ✔ For all hair style \n ✔ Suitable for babies and adults. \n ✔ Smooth and non-tangled hair after wash \n ✔ No fragrance"),
];
