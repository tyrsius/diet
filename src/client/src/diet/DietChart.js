import React from 'react'
import { map, evolve, sortBy, prop, pipe } from 'ramda'
import dayjs from 'dayjs'
import {
  LineChart,
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
  map(evolve({ date: d => dayjs(d).format('DD/MM') }))
)
const chartMarginStyle = {
  top: 5,
  right: 30,
  left: 20,
  bottom: 5
}

export default function DietChart({ logs }) {
  if (!logs) return null
  logs = chartTransform(logs)
  return (
    <div className="diet-wrapper">
      <div className="chart">
        <ResponsiveContainer>
          <LineChart syncId="diet" data={logs} margin={chartMarginStyle}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="date" />
            <Tooltip />
            <Legend />
            <YAxis
              dataKey="calories"
              yAxisId="left"
              stroke="#8884d8"
              domain={['dataMin - 1000', 'dataMax + 10']}
            />
            <YAxis
              dataKey="fat"
              yAxisId="right"
              orientation="right"
              stroke="#82ca9d"
              domain={[0, 'dataMax + 20']}
            />
            <Line
              type="monotone"
              yAxisId="right"
              dataKey="fat"
              stroke="#ffc658"
            />
            <Line
              type="monotone"
              yAxisId="right"
              dataKey="carbs"
              stroke="#82ca9d"
            />
            <Line
              type="monotone"
              yAxisId="right"
              dataKey="protien"
              stroke="#ff7300"
            />
            <Line
              type="monotone"
              yAxisId="left"
              dataKey="calories"
              stroke="#8884d8"
            />
          </LineChart>
        </ResponsiveContainer>
      </div>
      <div className="chart">
        <ResponsiveContainer>
          <LineChart syncId="diet" data={logs} margin={chartMarginStyle}>
            <CartesianGrid strokeDasharray="3 3" />
            <XAxis dataKey="date" />
            <Tooltip />
            <Legend />
            <YAxis domain={['dataMin - 5', 'dataMax + 7']} />

            <Line type="monotone" dataKey="weight" />
          </LineChart>
        </ResponsiveContainer>
      </div>
    </div>
  )
}
