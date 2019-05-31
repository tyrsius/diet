import React from 'react'
import { map, evolve, sortBy, prop, pipe } from 'ramda'
import dateformat from 'dateformat'
import {
  AreaChart,
  LineChart,
  Area,
  Line,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer
} from 'recharts'
import './dietChart.css'

const chartTransform = pipe(
  sortBy(prop('date')),
  map(evolve({ date: d => dateformat(d, 'mm/dd') }))
)

const chartMargin = { top: 5, right: 0, bottom: 5, left: 0 }
const xTickMargin = 10

export default function DietChart({ logs }) {
  if (!logs) return null
  logs = chartTransform(logs)
  return (
    <div className="diet-wrapper">
      <div className="chart">
        <ResponsiveContainer>
          <LineChart syncId="diet" data={logs} margin={chartMargin}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="date" tickMargin={xTickMargin} />
            <Tooltip />
            <Legend />
            <YAxis
              dataKey="calories"
              yAxisId="calories"
              orientation="right"
              stroke="#8884d8"
              domain={['dataMin - 1000', 'dataMax + 10']}
            />
            <YAxis
              dataKey="fat"
              yAxisId="fat"
              orientation="left"
              stroke="#ffc658"
              domain={[0, 'dataMax + 20']}
            />
            <Line
              type="monotone"
              yAxisId="fat"
              dataKey="fat"
              stroke="#ffc658"
            />
            <Line
              type="monotone"
              yAxisId="fat"
              dataKey="carbs"
              stroke="#82ca9d"
            />
            <Line
              type="monotone"
              yAxisId="fat"
              dataKey="protien"
              stroke="#ff7300"
            />
            <Line
              type="monotone"
              yAxisId="calories"
              dataKey="calories"
              stroke="#8884d8"
            />
          </LineChart>
        </ResponsiveContainer>
      </div>
      <div className="chart">
        <ResponsiveContainer>
          <AreaChart syncId="diet" data={logs} margin={chartMargin}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="date" tickMargin={xTickMargin} />
            <Tooltip />
            <Legend />
            <YAxis domain={['dataMin - 5', 'dataMax + 7']} />
            <Area type="monotone" dataKey="weight" />
          </AreaChart>
        </ResponsiveContainer>
      </div>
    </div>
  )
}
