import SwiftUI
import Charts

struct PerformanceChart: View {
    @StateObject var viewModel: CoinDetailViewModel
    @State private var selectedTimePeriod: TimePeriod? = nil

    var body: some View {
        VStack {
            chartContent
            TimePeriodSelector()
        }
    }

    @ViewBuilder
    private var chartContent: some View {
        switch viewModel.chartDataState {
        case .loading:
            LoadingView()

        case .error(let error):
            ErrorView(error: error)

        case .loaded(let chartData):
            ChartView(points: chartData)
        }
    }

    @ViewBuilder
    private func LoadingView() -> some View {
        Text("Chart data is loading...")
            .frame(height: 200)
            .font(.subheadline)
            .foregroundColor(.gray)
    }

    @ViewBuilder
    private func ErrorView(error: Error) -> some View {
        Text("Error loading chart: \(error.localizedDescription)")
            .frame(height: 200)
            .foregroundColor(.red)
            .padding()
    }

    @ViewBuilder
    private func ChartView(points: [PerformanceChartData]) -> some View {
        Chart {
            ForEach(points, id: \.self) { point in
                AreaMark(
                    x: .value("Date", point.x),
                    y: .value("Value", point.y)
                )
            }
        }
        .chartYAxisLabel("Price")
        .chartXAxisLabel("Time")
        .frame(height: 200)
    }

    private func TimePeriodSelector() -> some View {
        LazyHGrid(rows: [GridItem(.flexible())]) {
            ForEach(TimePeriod.allCases, id: \.self) { time in
                Button(action: {
                    Task {
                        await viewModel.loadCoinHistory(timePeriod: time)
                    }
                    selectedTimePeriod = time
                }) {
                    Text(time.rawValue)
                        .font(.system(size: 8))
                        .padding(8)
                        .background(selectedTimePeriod == time ? Color.purple : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.top, 8)
    }
}
