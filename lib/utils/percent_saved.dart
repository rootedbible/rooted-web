String percentSaved(double monthlyPrice, double annualPrice) =>
    '${(((monthlyPrice * 12 - annualPrice) / (monthlyPrice * 12)) * 100).round()}%';
